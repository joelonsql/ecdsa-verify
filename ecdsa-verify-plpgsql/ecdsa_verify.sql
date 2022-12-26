CREATE OR REPLACE FUNCTION modular_inverse(divisor numeric, mod numeric)
RETURNS numeric
LANGUAGE plpgsql
AS $$
declare

  t numeric := 0;
  new_t numeric := 1;
  r numeric := mod;
  new_r numeric := divisor;
  quotient numeric;

begin

  if mod = 0 or mod = 1 then
    return null;
  end if;

  while new_r != 0 loop
    quotient := div(r, new_r);
    SELECT new_t, t - quotient * new_t INTO t, new_t;
    SELECT new_r, r - quotient * new_r INTO r, new_r;
  end loop;

  if r > 1 then
    return null;
  elsif t < 0 then
    t := t + mod;
  end if;

  return t;

end;
$$;

CREATE OR REPLACE FUNCTION number_from_byte_string(bytea)
RETURNS numeric
LANGUAGE plpgsql
AS $$
declare

  bits bit varying;
  result numeric := 0;
  exponent numeric := 0;
  bit_pos integer;

begin

  execute 'SELECT x' || quote_literal(substr($1::text,3)) into bits;
  bit_pos := length(bits) + 1;
  exponent := 0;

  while bit_pos >= 56 loop
    bit_pos := bit_pos - 56;
    result := result + substring(bits from bit_pos for 56)::bigint::numeric * pow(2::numeric, exponent);
    exponent := exponent + 56;
  end loop;

  while bit_pos >= 8 loop
    bit_pos := bit_pos - 8;
    result := result + substring(bits from bit_pos for 8)::bigint::numeric * pow(2::numeric, exponent);
    exponent := exponent + 8;
  end loop;

  return trunc(result);

end;
$$;
 
CREATE OR REPLACE FUNCTION byte_string_from_number(numeric)
RETURNS bytea
LANGUAGE plpgsql
AS $$
declare

  result bytea := '';
  exponent bigint;
  val numeric;
  byte bytea;
  chunk_radix numeric;

begin

  if $1 = 0 then
    return '\x'::bytea;
  end if;

  chunk_radix := 256^6;
  exponent := floor(log(abs($1)) / log(chunk_radix));
  while exponent >= 0 loop
    val := floor($1 / power(chunk_radix, exponent));
    byte := decode(lpad(to_hex(val::bigint),12,'0'),'hex');
    result := result || byte;
    $1 := $1 - power(chunk_radix, exponent) * val;
    exponent := exponent - 1;
  end loop;

  return ltrim(result,'\x00'::bytea);

end;
$$;

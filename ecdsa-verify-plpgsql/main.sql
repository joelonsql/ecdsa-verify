\ir ecdsa_verify.sql

SELECT byte_string_from_number(
    modular_inverse(
        number_from_byte_string(:a),
        number_from_byte_string(:n)
    )
);

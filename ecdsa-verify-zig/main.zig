const std = @import("std");
const bigint = std.math.big.int.Managed;
const os = std.os;
const testing = std.testing;

fn modular_inverse(a: *bigint, n: *bigint) !bigint {
    var zero = try bigint.initSet(std.heap.c_allocator, 0);
    var one = try bigint.initSet(std.heap.c_allocator, 1);
    defer zero.deinit();
    defer one.deinit();
    if (n.eq(zero) or n.eq(one)) {
        return error.NoModularInverse;
    }
    var t = try bigint.initSet(std.heap.c_allocator, 0);
    var newt = try bigint.initSet(std.heap.c_allocator, 1);
    var r = try bigint.initSet(std.heap.c_allocator, 0);
    var newr = try bigint.initSet(std.heap.c_allocator, 0);
    defer newt.deinit();
    defer r.deinit();
    defer newr.deinit();
    try r.copy(n.toConst());
    try newr.copy(a.toConst());
    var quotient = try bigint.initSet(std.heap.c_allocator, 0);
    var remainder = try bigint.initSet(std.heap.c_allocator, 0);
    var tmp1 = try bigint.initSet(std.heap.c_allocator, 0);
    var tmp2 = try bigint.initSet(std.heap.c_allocator, 0);
    var tmp3 = try bigint.initSet(std.heap.c_allocator, 0);
    defer tmp1.deinit();
    defer tmp2.deinit();
    defer tmp3.deinit();
    while (!newr.eqZero()) {
        try bigint.divFloor(&quotient, &remainder, &r, &newr);
        try tmp1.copy(t.toConst());
        try t.copy(newt.toConst());
        try bigint.mul(&tmp3, &quotient, &newt);
        try newt.sub(&tmp1, &tmp3);
        try tmp2.copy(r.toConst());
        try r.copy(newr.toConst());
        try bigint.mul(&tmp3, &quotient, &newr);
        try newr.sub(&tmp2, &tmp3);
    }
    if (r.order(one) == .gt) {
        return error.NoModularInverse;
    }
    if (t.order(zero) == .lt) {
        try bigint.add(&t, &t, n);
    }
    return t;
}

pub fn main() !void {
    if (os.argv.len != 3) {
        std.debug.print("Expected two hexadecimal strings as arguments\n", .{});
        return;
    }
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    var a = try bigint.init(std.heap.page_allocator);
    var n = try bigint.init(std.heap.page_allocator);
    defer a.deinit();
    defer n.deinit();
    try a.setString(16, args[1]);
    try n.setString(16, args[2]);
    var result = try bigint.init(std.heap.page_allocator);
    result = try modular_inverse(&a, &n);
    std.debug.print("{x}\n", .{result});
}

test "modular_inverse" {
    var a = try bigint.initSet(std.heap.page_allocator, 0x69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057);
    var n = try bigint.initSet(std.heap.page_allocator, 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141);
    defer a.deinit();
    defer n.deinit();
    var expected_result = try bigint.initSet(std.heap.page_allocator, 0x321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0);
    defer expected_result.deinit();
    var result = try modular_inverse(&a, &n);
    try testing.expect(result.eq(expected_result));
}

test "modular_inverse_no_inverse" {
    var a = try bigint.initSet(std.heap.page_allocator, 4);
    var n = try bigint.initSet(std.heap.page_allocator, 6);
    defer a.deinit();
    defer n.deinit();
    try testing.expectError(error.NoModularInverse, modular_inverse(&a, &n));
    try n.set(0);
    try testing.expectError(error.NoModularInverse, modular_inverse(&a, &n));
    try n.set(1);
    try testing.expectError(error.NoModularInverse, modular_inverse(&a, &n));
}
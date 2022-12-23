const std = @import("std");
const bigint = std.math.big.int.Managed;
const os = std.os;
const testing = std.testing;
const Allocator = std.mem.Allocator;

fn modular_inverse(allocator: Allocator, a: *bigint, n: *bigint) !bigint {
    var zero = try bigint.initSet(allocator, 0);
    defer zero.deinit();
    var one = try bigint.initSet(allocator, 1);
    defer one.deinit();

    if (n.eq(zero) or n.eq(one)) {
        return error.NoModularInverse;
    }

    var t = try bigint.initSet(allocator, 0);
    errdefer t.deinit();
    var newt = try bigint.initSet(allocator, 1);
    defer newt.deinit();
    var r = try bigint.init(allocator);
    defer r.deinit();
    var newr = try bigint.init(allocator);
    defer newr.deinit();

    try r.copy(n.toConst());
    try newr.copy(a.toConst());

    var quotient = try bigint.init(allocator);
    defer quotient.deinit();
    var remainder = try bigint.init(allocator);
    defer remainder.deinit();
    var tmp = try bigint.init(allocator);
    defer tmp.deinit();

    while (!newr.eqZero()) {
        try quotient.divFloor(&remainder, &r, &newr);

        try tmp.mul(&quotient, &newt);
        t.swap(&newt);
        try newt.sub(&newt, &tmp);

        try tmp.mul(&quotient, &newr);
        r.swap(&newr);
        try newr.sub(&newr, &tmp);
    }
    if (r.order(one) == .gt) {
        return error.NoModularInverse;
    }
    if (t.order(zero) == .lt) {
        try t.add(&t, n);
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
    defer a.deinit();
    var n = try bigint.init(std.heap.page_allocator);
    defer n.deinit();
    try a.setString(16, args[1]);
    try n.setString(16, args[2]);
    var result = try bigint.init(std.heap.page_allocator);
    result = try modular_inverse(std.heap.page_allocator, &a, &n);
    std.debug.print("{x}\n", .{result});
}

test "modular_inverse" {
    var a = try bigint.initSet(std.heap.page_allocator, 0x69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057);
    defer a.deinit();
    var n = try bigint.initSet(std.heap.page_allocator, 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141);
    defer n.deinit();
    var expected_result = try bigint.initSet(std.heap.page_allocator, 0x321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0);
    defer expected_result.deinit();
    var result = try modular_inverse(std.heap.page_allocator, &a, &n);
    try testing.expect(result.eq(expected_result));
}

test "modular_inverse_no_inverse" {
    var a = try bigint.initSet(std.heap.page_allocator, 4);
    defer a.deinit();
    var n = try bigint.initSet(std.heap.page_allocator, 6);
    defer n.deinit();
    try testing.expectError(error.NoModularInverse, modular_inverse(std.heap.page_allocator, &a, &n));
    try n.set(0);
    try testing.expectError(error.NoModularInverse, modular_inverse(std.heap.page_allocator, &a, &n));
    try n.set(1);
    try testing.expectError(error.NoModularInverse, modular_inverse(std.heap.page_allocator, &a, &n));
}
const std = @import("std");

pub fn main() !void {
    var args = std.process.args();
    _ = args.skip();

    const filename = args.next() orelse "../input.txt";

    const file: std.fs.File = try std.fs.cwd().openFile(filename, .{ .mode = .read_only });
    defer file.close();

    const chall = args.next() orelse "";

    if (std.mem.eql(u8, chall, "1")) {
        try solution(file, 2);
    } else if (std.mem.eql(u8, chall, "2")) {
        try solution(file, 12);
    }
}

fn solution(file: std.fs.File, joltage_size: usize) !void {
    var line_buffer: [101]u8 = undefined;
    var reader: std.fs.File.Reader = file.reader(&line_buffer);

    var total: u64 = 0;

    while (try reader.interface.takeDelimiter('\n')) |line| {
        var line_total: u64 = 0;
        var int_buffer: [100]u8 = undefined;
        for (line, 0..) |char, index| {
            int_buffer[index] = char - '0';
        }
        var current_highest: u8 = 0;
        var last_num_index: u8 = 0;
        for (0..joltage_size) |i| {
            for (int_buffer[last_num_index .. 100 - ((joltage_size - 1) - i)], last_num_index..) |number, index| {
                if (number > current_highest) {
                    current_highest = number;
                    last_num_index = @intCast(index);
                }
            }
            last_num_index += 1;
            const power: u64 = @intCast(i);
            line_total += (current_highest * std.math.pow(u64, 10, (joltage_size - power) - 1));
        }
        total += line_total;
    }
    std.debug.print("{d}\n", .{total});
}

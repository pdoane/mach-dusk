const std = @import("std");
const builtin = @import("builtin");

// TODO - maybe configure like GPUInterface?
pub const enabled = builtin.mode == .Debug;

pub const EncoderState = enum {
    open,
    locked,
    ended,
};

pub fn commands_mixin_validate(comptime T: type, encoder: *T) bool {
    return switch (encoder.state) {
        .open => return true,
        .locked => {
            encoder.valid = false;
            return false;
        },
        .ended => {
            // TODO - generate a validation error
            return false;
        },
    };
}

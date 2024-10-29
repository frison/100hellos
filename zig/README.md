# Zig

Zig supports compile time code execution, which means you can run code at compile time to generate more code. This can be used for things like generating boilerplate code, or even for more complex tasks like parsing files or generating data structures. This can be a powerful tool for metaprogramming, and can help you write more concise and maintainable code.

This means you can add blocks to your code that execute at compile time with:

```zig
comptime {
    // code that runs at compile time
}
```

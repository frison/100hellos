# Elixir

Elixir is a dynamic, functional language for building scalable and maintainable applications.
Elixir runs on the Erlang VM, known for creating low-latency, distributed, and fault-tolerant systems. These capabilities and Elixir tooling allow developers to be productive in several domains, such as web development, embedded software, machine learning, data pipelines, and multimedia processing, across a wide range of industries.

Here is a peek:
```
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```
Platform features
Scalability
All Elixir code runs inside lightweight threads of execution (called processes) that are isolated and exchange information via messages:

Due to their lightweight nature, you can run hundreds of thousands of processes concurrently in the same machine, using all machine resources efficiently (vertical scaling). Processes may also communicate with other processes running on different machines to coordinate work across multiple nodes (horizontal scaling).



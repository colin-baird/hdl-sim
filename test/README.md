# Graph.ml Test Suite

This directory contains comprehensive unit tests for the `Graph.ml` module, which implements data structures and algorithms for creating and manipulating directed acyclic graphs (DAGs) used in HDL simulation.

## Running the Tests

To run the test suite:

```bash
dune test
```

Or from the project root:

```bash
cd /path/to/hdl-sim && dune test
```

## Test Coverage

The test suite includes 12 tests covering the following functionality:

### Core Data Structure Tests

1. **Empty DAG Creation** - Tests creating an empty netlist and DAG
2. **ID Map Creation** - Tests the `create_id_map` function that maps signal IDs to nodes

### Graph Construction Tests

3. **Linear DAG** - Tests a simple chain: A → B → C
4. **Fan-out DAG** - Tests one node with multiple children (A → B, A → C, A → D)
5. **Fan-in DAG** - Tests multiple nodes feeding into one (A → C, B → C)
6. **Complex DAG** - Tests a more complex graph structure with multiple paths

### Topological Sort Tests

7. **Linear Chain Sort** - Verifies topological ordering for a linear dependency chain
8. **Diamond Pattern Sort** - Tests topological ordering for a diamond-shaped dependency graph

### Node Property Tests

9. **Register Nodes** - Tests nodes with the `is_reg` flag set
10. **Different Operations** - Tests nodes with various operation types (Op, Ternary, Concat, Slice, Index, None)
11. **Empty Inputs** - Tests nodes with no input dependencies

### Helper Function Tests

12. **add_child Function** - Tests the `add_child` helper function directly

## Test Structure

Each test follows this pattern:

1. **Setup** - Create test nodes and netlists
2. **Execution** - Call the function being tested
3. **Verification** - Assert expected results
4. **Reporting** - Print success message

## Helper Functions

- `make_node` - Convenience function to create nodes with optional parameters
- `nodes_equal` - Compares two nodes for equality

## Test Output

When all tests pass, you'll see:

```
=== Running Graph.ml Test Suite ===

✓ Test 1 passed: Empty DAG creation
✓ Test 2 passed: Linear DAG creation
...
✓ Test 12 passed: add_child function

=== All tests passed! ===
```

## Compatibility

This test suite is fully compatible with the dune build system and integrates seamlessly with the HDL simulator project structure.

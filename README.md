# LLM Memory Layout RS

Data layout and data reuse can significantly affect LLM inference performance. This project uses CPU experiments to quantitatively investigate these effects in two stages.
1. **KV cache layouts and loop ordering**: How do different combinations of physical KV cache layout and loop order affect performance across sequence lengths, head counts, and subsets of heads being processed?
2. **Weight and activation tile reuse**: How should weight, activation, and output tiles be retained in fast memory to reduce total data movement and execution time, given the number of token rows processed and the available memory capacity? 

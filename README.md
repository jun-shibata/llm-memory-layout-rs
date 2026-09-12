# LLM Memory Layout RS

Data layout and data reuse can significantly affect LLM inference performance. This project uses CPU experiments to quantitatively investigate these effects in two stages.
1. **KV cache layouts and loop ordering**: How do different combinations of physical KV cache layout and loop order affect performance across sequence lengths, head counts, and subsets of heads being processed?
2. **Weight and activation tile reuse**: How should weight, activation, and output tiles be retained in fast memory to reduce total data movement and execution time, given the number of token rows processed and the available memory capacity? 

 
 ## Performance Analysis of qK Dot‑Product Under SHD and HSD Layouts
 I measured the dot-product between $ q $ and $ K $ for a fixed single head using an identical loop order.
 When $ H = 1 $, the execution times of the SHD and HSD layouts were nearly indistinguishable. In contrast, for $ H > 1 $, the HSD layout consistently outperformed SHD, particularly for long sequence lengths. For instance, at $ S = 32768, H = 32 $, and $ D = 128 $, HSD achieved approximately **2.66x** shorter execution time.

 These findings indicate that performance is influenced not only by continuity along the dot-product dimension but also by the data arrangement when traversing the same head across the sequence dimension. Nevertheless, identifying the precise contributing factors requires additional analysis of the generated instructions and memory access patterns. The present evaluation is limited to the $qK$ dot-product in isolation; its implications for the overall Attention computation or multi-head processing remain to be investigated.
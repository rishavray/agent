#!/bin/bash

#usage is run_agent <old_assembly> <target_assembly> <min_overlap> <threads> <output_chain_name>
./bin/lastdb -cR01 old $1
./bin/lastal -l $3 -P $4 old $3 | maf-convert psl - > mapping.psl


./bin/faToTwoBit $1 old.2bit
./bin/faToTwoBit $2 target.2bit
./bin/twoBitInfo old.2bit stdout | sort -k2,2nr > old.chrom.sizes
./bin/twoBitInfo target.2bit stdout | sort -k2,2nr > target.chrom.sizes


./bin/axtChain -linearGap=medium -psl mapping.psl old.2bit target.2bit out.chain

./bin/chainNet out.chain old.chrom.sizes target.chrom.sizes out.net /dev/null
./bin/netChainSubset out.net out.chain $5


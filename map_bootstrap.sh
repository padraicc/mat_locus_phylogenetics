#!/bin/bash


java -Xmx4g -jar phyutility.jar -ts -in data/raxml_results/RAxML_bootstrap.matA123.boot.tre -tree data/raxml_results/RAxML_bestTree.matA123.best.tre -out data/raxml_results/matA123.raxml.tre

java -Xmx4g -jar phyutility.jar -ts -in data/raxml_results/RAxML_bootstrap.mat_a1.boot.tre -tree data/raxml_results/RAxML_bestTree.mat_a1.best.tre -out data/raxml_results/mat_a1.raxml.tre

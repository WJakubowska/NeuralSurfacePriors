#!/bin/bash

if [ ! -f /workspace/container_initialized ]; then
    echo "Running setup script..."
    git clone --recursive https://github.com/RaduAlexandru/easy_pbr
    cd easy_pbr && make && cd ..

    git clone --recursive https://github.com/RaduAlexandru/data_loaders
    cd data_loaders && make && cd ..

    git clone --recursive https://github.com/RaduAlexandru/permutohedral_encoding
    cd permutohedral_encoding && make && cd ..

    git clone --recursive https://github.com/WJakubowska/permuto_sdf.git
    cd permuto_sdf/permuto_sdf_py
    chmod +x train_permuto_sdf.py
    cd ..
    cd ..
    cd permuto_sdf && make && cd ..

    git clone --recursive https://github.com/WJakubowska/3DGS_for_SDF.git
    cd 3DGS_for_SDF
    pip install -q plyfile
    pip install -q trimesh
    chmod +x train.py
    pip install -q submodules/diff-gaussian-rasterization
    pip install -q submodules/simple-knn
    cd ..
    touch /workspace/container_initialized
else
    cd easy_pbr && make && cd ..
    cd data_loaders && make && cd ..
    cd permutohedral_encoding && make && cd ..
    cd permuto_sdf && make && cd ..
    cd 3DGS_for_SDF
    pip install -q plyfile 
    pip install -q trimesh
    pip install -q submodules/diff-gaussian-rasterization
    pip install -q submodules/simple-knn
    cd ..
    echo "Container is ready to work :) "
fi

exec "$@"
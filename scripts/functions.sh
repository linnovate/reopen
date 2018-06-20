#!/bin/bash -xe

function real_path() {
    local base_dir relative_path start_dir real_path

    base_dir=$1
    relative_path=$2
    start_dir=$(pwd)
    cd $base_dir
    real_path=$(readlink -f -- $relative_path)
    cd $start_dir

    echo $real_path
}


function set_docker_compose_env() {
    local docker_dir deploy_env

    docker_dir=$1
    deploy_env=$2

    # set the environment for docker-compose
    cp $docker_dir/.env.$deploy_env $docker_dir/.env ||
        echo "WARNING! Deploy environment not specified. Defaulting to current .env " >&2
}

function get_docker_compose_services() {
    local docker_dir start_dir services

    docker_dir=$1

    start_dir=$(pwd)

    set_docker_compose_env $docker_dir

    cd $docker_dir
    services=$(docker-compose config --services)
    cd $start_dir

    echo $services
}

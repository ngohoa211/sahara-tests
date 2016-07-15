<%page args="is_proxy_gateway='true'"/>

clusters:
  - plugin_name: storm
    plugin_version: 1.0.1
    image: ${storm_1_0_image}
    node_group_templates:
      - name: master
        flavor: ${ci_flavor_id}
        node_processes:
          - nimbus
        auto_security_group: true
        is_proxy_gateway: ${is_proxy_gateway}
      - name: worker
        flavor: ${ci_flavor_id}
        node_processes:
          - supervisor
        auto_security_group: true
      - name: zookeeper
        flavor: ${medium_flavor}
        node_processes:
          - zookeeper
        auto_security_group: true
    cluster_template:
      name: storm101
      node_group_templates:
        master: 1
        worker: 1
        zookeeper: 1
    cluster:
      name: ${cluster_name}
    scaling:
      - operation: add
        node_group: worker
        size: 1
    scenario:
       - scale
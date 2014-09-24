# moni-cookbook

use influxdb and graphite-api

## Supported Platforms

ubuntu 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['moni']['discovery']</tt></td>
    <td>String</td>
    <td>which role to discover (for chef-zero in vagrant and aws opsworks)</td>
    <td><tt>true</tt></td>
  </tr>
</table>

### chef roles

Layer: Influxdb

```json
{
    "name": "influxdb",
    "description": "influxdb layer",
    "default_attributes": {
      "moni": {
        "discovery": "influxdb"
      }
    },  
    "run_list": [
        "recipe[moni::influxdb]"
    ],  
    "chef_type": "role",
    "json_class": "Chef::Role"
}
```

Layer: Graphite

```json
{
    "name": "graphite",
    "description": "graphite layer",
    "default_attributes": {
      "moni": {
        "graphite": {
          "influxdb_path": "192.168.89.221"
        }
      }
    },  
    "run_list": [
        "recipe[moni::graphite]"
    ],  
    "chef_type": "role",
    "json_class": "Chef::Role"
}
```

## License and Authors

Author:: Jimmy Yang (<gankkank@gmail.com>)

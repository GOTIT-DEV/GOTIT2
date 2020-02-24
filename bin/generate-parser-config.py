#!/usr/bin/env python3

import yaml
import os

DIR = "src/Bbees/E3sBundle/Resources/config/doctrine/metadata/orm"
OUTPUT = "src/Lehna/QueryBuilderBundle/Resources/config/parser-config.yml"
TEST_FILE = os.path.join(DIR, "Adn.orm.yml")

VALID_TYPES = ["string", "integer", "double",
               "date", "time", "datetime", "boolean"]

CLASS_PREFIX = "Bbees\\E3sBundle\\Entity\\"


def generate_config(orm_dir=DIR, out_file=OUTPUT):
    parser_conf = {
        "builders": {},
        "doctrine_classes_and_mappings": {}
    }

    file_list = os.listdir(DIR)
    for filename in file_list:
        path = os.path.join(DIR, filename)
        parsed_entity = parse_file(path)
        for k, v in parsed_entity.items():
            parser_conf[k].update(v)

    # wrapping up
    parser_conf = {"fl_qbjs_parser": parser_conf}

    with open(out_file, 'w') as fo:
        data = yaml.dump(parser_conf, fo)
    return data


def parse_file(file_path):
    name = os.path.basename(file_path).split('.')[0]
    print(name)
    output = {
        "filters": [],
        "result_columns": [],  # change this
        "class": CLASS_PREFIX + name,
    }
    with open(file_path, 'r') as fh:
        entity = yaml.safe_load(fh)[name]
        table = entity["table"]
    
        output["human_readable_name"] = table

        id_key, id_field = next(iter(entity["id"].items()))
        id_filter = filter_from_field(id_key, id_field)
        output["filters"].append(id_filter)

        for f_name, f_data in entity["fields"].items():
            filt = filter_from_field(f_name, f_data)
            output["filters"].append(filt)

        mappings = get_mappings(output)

        if "manyToOne" in entity:
            related = {
                k: CLASS_PREFIX + v["targetEntity"]
                for k, v in entity["manyToOne"].items()
            }
            mappings["association_classes"] = related

    return {
        "builders": {table: output},
        "doctrine_classes_and_mappings": {table: mappings}
    }


def get_mappings(entity_dict):
    output = {
        "class": entity_dict["class"],
        "properties": {
            field["id"]: None for field in entity_dict["filters"]
        }
    }
    return output


def filter_from_field(field_name, data):

    field_type = convert_type(data["type"])
    column = data.get("column", field_name)
    return {
        "id": field_name,
        "label": field_name,  # change this
        "type": field_type
        # "column": column
    }


def convert_type(t):
    if "int" in t:
        t = "integer"
    elif "bool" in t:
        t = "boolean"
    elif "float" in t:
        t = "double"
    elif "text" in t:
        t = "string"
    assert t in VALID_TYPES
    return t


if __name__ == "__main__":
    res = generate_config()
    print(res)

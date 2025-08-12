---
layout: default  
title: Keyword Node  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Keyword Node  
**Description**: The keywords_node dataset is used in the RED-X application to represent keyword nodes within the research network visualization. Each row corresponds to a unique keyword found in the research metadata, along with attributes that help categorize, color-code, and display connections in the app’s interactive network plot. The network allows users to explore how specific keywords are distributed across departments, colleges, and over time, offering a visual overview of research trends and thematic overlaps. In the app, each keyword node is connected to others through shared appearances in the same studies (captured in a separate keywords_edge.csv file). When a user clicks on a node, the app highlights related keywords and reveals metadata for associated studies. The node color represents its affiliated college or department, making it easier to see institutional patterns. This dataset underpins the keyword filtering functionality in RED-X and supports discovery of related research themes through visual exploration.  
**Classification**: RDF212  
**Schema package SAID**: EIQeu3xRmf0uz6xR2rFekFRQVrN2x0ub5CI4DIfLcEk8  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| label | label | The keyword term (e.g., “Soil Health”) used as the unique node label |
| node_group | Node group | Classification of the node group (e.g., “Keywords”) |
| title | title | Tooltip-style summary (e.g., \"Study Count: 3 Year Range: 2017 to 2021\") |
| CollegeColor | College Color | Name of the college associated with the keyword\'s studies |
| DepartmentColor | Department Color | Name of the department tied to the keyword’s usage |
| CollegeName | College Name | Hex color code used for visualizing college-affiliation in the network |
| DepartmentName | Department Name | Hex color code used for department-affiliation in the network |
| study_count | Study count | Number of studies in which the keyword appears |
| year_range | Year range | Representation of publication years for the studies |
| DOI | DOI | Unique identifier for each studies in which the keywords appear |
| id | id | Unique identifier assigned to each node |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Keyword Node | The keywords_node dataset is used in the RED-X application to represent keyword nodes within the research network visualization. Each row corresponds to a unique keyword found in the research metadata, along with attributes that help categorize, color-code, and display connections in the app’s interactive network plot. The network allows users to explore how specific keywords are distributed across departments, colleges, and over time, offering a visual overview of research trends and thematic overlaps. In the app, each keyword node is connected to others through shared appearances in the same studies (captured in a separate keywords_edge.csv file). When a user clicks on a node, the app highlights related keywords and reveals metadata for associated studies. The node color represents its affiliated college or department, making it easier to see institutional patterns. This dataset underpins the keyword filtering functionality in RED-X and supports discovery of related research themes through visual exploration. |

## Language-independent schema details

| Attribute | Sensitive | Unit | Type | Character encoding | Required entry | Format rule |
| --- | --- | --- | --- | --- | --- | --- |
| label | false |  | Text | utf-8 | true |  |
| node_group | false |  | Text | utf-8 | true |  |
| title | false |  | Text | utf-8 | true |  |
| CollegeColor | false |  | Text | utf-8 | true | ^\#\(?:\[0\-9a\-fA\-F\]\{3\}\|\[0\-9a\-fA\-F\]\{6\}\)$ |
| DepartmentColor | false |  | Text | utf-8 | true | ^\#\(?:\[0\-9a\-fA\-F\]\{3\}\|\[0\-9a\-fA\-F\]\{6\}\)$ |
| CollegeName | false |  | Text | utf-8 | true |  |
| DepartmentName | false |  | Text | utf-8 | true |  |
| study_count | false |  | Numeric |  | true | ^\\d\+$ |
| year_range | false |  | Text | utf-8 | true |  |
| DOI | false |  | Text | utf-8 | true | ^doi:10\\\.\\d\{4,9\}/\[\-\.\_;\(\)/:Aa\-Zz0\-9\]\+$ |
| id | false |  | Numeric |  | true | ^\\d\+$ |

## Language-specific schema details

### English

| Attribute | Label | Description | List |
| --- | --- | --- | --- |
| label | label | The keyword term (e.g., “Soil Health”) used as the unique node label | Not a list |
| node_group | Node group | Classification of the node group (e.g., “Keywords”) | Not a list |
| title | title | Tooltip-style summary (e.g., \"Study Count: 3 Year Range: 2017 to 2021\") | Not a list |
| CollegeColor | College Color | Name of the college associated with the keyword\'s studies | Not a list |
| DepartmentColor | Department Color | Name of the department tied to the keyword’s usage | Not a list |
| CollegeName | College Name | Hex color code used for visualizing college-affiliation in the network | Not a list |
| DepartmentName | Department Name | Hex color code used for department-affiliation in the network | Not a list |
| study_count | Study count | Number of studies in which the keyword appears | Not a list |
| year_range | Year range | Representation of publication years for the studies | Not a list |
| DOI | DOI | Unique identifier for each studies in which the keywords appear | Not a list |
| id | id | Unique identifier assigned to each node | Not a list |

## Schema SAIDs

**Capture base**: EErvygNKDSiSJlIyI1Xr5ptemkmRGXViH2nPYmU9TuYM

**Bundle**: EAJNbuReH5ndB3zgGyBAMQEglFEe-bPEHF2qubsGbU8N

**Package**: EIQeu3xRmf0uz6xR2rFekFRQVrN2x0ub5CI4DIfLcEk8

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EId4qK9jG2jiI_gDciiBUKVv4vd26tevKxMo2v1te5oy | spec/overlays/character_encoding/1.1 |
| conformance | ECQzJ3PfDLsCtqaFHm3uVPs9uQIGzuRkLYR2YHRiTtuP | spec/overlays/conformance/1.1 |
| format | EPJeUB-M-d9za2yW8ST6gbVDbBeAYWZHdbY8FUIW_qHZ | spec/overlays/format/1.1 |
| information (eng) | EGTltT9R6zYsr1N17beLBCrMZ9ffJuKKSIf9HaRBRnDV | spec/overlays/information/1.1 |
| label (eng) | EIlTOVOjITxYQWmtTQIuwQ4ZEA9WNWF9vQBthYtrRP00 | spec/overlays/label/1.1 |
| meta (eng) | EFu1lA89ounWzPVa6XRyPwhOle06-XzyNSoyrlgp7Y5_ | spec/overlays/meta/1.1 |
| ordering | EP6PBzIq0meI-CrbjYiJ0zqO6cb5rvDBo0DrEP_4mzEY | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-31 05:31:16


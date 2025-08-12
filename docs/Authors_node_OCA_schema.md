---
layout: default  
title: Authors Nodes  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Authors Nodes  
**Description**: The authors_node dataset is part of the RED-X application\'s network visualization layer. It represents author nodes in the research network, where each row corresponds to an individual author or research group identified in the study metadata. The dataset includes details such as the author name, the number of studies they contributed to, associated departments and colleges, color assignments for visualization, and the range of years during which their work was published. This dataset enables users to interactively explore the relationships and collaboration patterns among authors across different departments and institutions.  
**Schema package SAID**: EKO783UxISz24bqUFtZkmPYh3JpSIfriG2CeY75XKCq9  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| label | label | Name of the author or research group. Used as the node label in the network. |
| node_group | Node group | Constant value \"Authors\" identifying this as an author node type. |
| title | Title | Tooltip showing study count and year range for hover info in the network plot. |
| CollegeColor | College Color | Hex color code used to color nodes based on college affiliation. |
| DepartmentColor | Department Color | Hex color code for department-level node coloring. |
| CollegeName | College Name | Name of the college affiliated with the author. |
| DepartmentName | Department Name | Name of the department or research unit. |
| study_count | Study count | Number of datasets (studies) the author is associated with. |
| year_range | Year range | Range of publication dates (earliest to latest) across all studies linked to the author. |
| DOI | DOI | One or more DOIs of the datasets contributed to by the author, separated by semicolons. |
| id | id | Unique identifier for the node (used to construct graph edges). |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Authors Nodes | The authors_node dataset is part of the RED-X application\'s network visualization layer. It represents author nodes in the research network, where each row corresponds to an individual author or research group identified in the study metadata. The dataset includes details such as the author name, the number of studies they contributed to, associated departments and colleges, color assignments for visualization, and the range of years during which their work was published. This dataset enables users to interactively explore the relationships and collaboration patterns among authors across different departments and institutions. |

## Language-independent schema details

| Attribute | Sensitive | Unit | Type | Character encoding | Required entry | Format rule |
| --- | --- | --- | --- | --- | --- | --- |
| label | false |  | Text | utf-8 | true |  |
| node_group | false |  | Text | utf-8 | true |  |
| title | false |  | Text | utf-8 | true |  |
| CollegeColor | false |  | Text | utf-8 | true | ^\#\[A\-Fa\-f0\-9\]\{6\}$ |
| DepartmentColor | false |  | Text | utf-8 | true | ^\#\[A\-Fa\-f0\-9\]\{6\}$ |
| CollegeName | false |  | Text | utf-8 | true |  |
| DepartmentName | false |  | Text | utf-8 | true |  |
| study_count | false |  | Numeric | utf-8 | true | ^\\d\+$ |
| year_range | false |  | Text | utf-8 | true |  |
| DOI | false |  | Text | utf-8 | true | ^doi:10\\\.\\d\{4,9\}/\[\-\.\_;\(\)/:Aa\-Zz0\-9\]\+$ |
| id | false |  | Numeric | utf-8 | true | ^\\d\+$ |

## Language-specific schema details

### English

| Attribute | Label | Description | List |
| --- | --- | --- | --- |
| label | label | Name of the author or research group. Used as the node label in the network. | Not a list |
| node_group | Node group | Constant value \"Authors\" identifying this as an author node type. | Not a list |
| title | Title | Tooltip showing study count and year range for hover info in the network plot. | Not a list |
| CollegeColor | College Color | Hex color code used to color nodes based on college affiliation. | Not a list |
| DepartmentColor | Department Color | Hex color code for department-level node coloring. | Not a list |
| CollegeName | College Name | Name of the college affiliated with the author. | Not a list |
| DepartmentName | Department Name | Name of the department or research unit. | Not a list |
| study_count | Study count | Number of datasets (studies) the author is associated with. | Not a list |
| year_range | Year range | Range of publication dates (earliest to latest) across all studies linked to the author. | Not a list |
| DOI | DOI | One or more DOIs of the datasets contributed to by the author, separated by semicolons. | Not a list |
| id | id | Unique identifier for the node (used to construct graph edges). | Not a list |

## Schema SAIDs

**Capture base**: EO57nBzzNO8FR1UjLfUtcUJDuFDG8dBUFWPsS5g0Cuqq

**Bundle**: EMmbDVCzAnMK3wKRjDH0gNAzQDJFOdo6DuROPPWU_uLf

**Package**: EKO783UxISz24bqUFtZkmPYh3JpSIfriG2CeY75XKCq9

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EG08VG7YfTMwbTecEK3SDG2OFkW6N-Bclc-6YCgs9yxs | spec/overlays/character_encoding/1.1 |
| conformance | ENPQNvHh1qFYXLI1hSCyhONY63P7zBIZo3cuAw1I_wVr | spec/overlays/conformance/1.1 |
| format | EN6Yx-pu1_UFyLofdxe_zycsaTC9d-7gSHj-AcK2U9s1 | spec/overlays/format/1.1 |
| information (eng) | EGqUI-5DmsOsc-McM2uhOE0EO3vgqaFybNTWhjC1LlB3 | spec/overlays/information/1.1 |
| label (eng) | EJ91_kBiFTO95ACwDikOvEG6QjB6EFDMOMhbdTrYUptH | spec/overlays/label/1.1 |
| meta (eng) | EHehpb0tr8qWbNr63WWlE-hbJ8Dyx5P-ecyOB50ZOS-x | spec/overlays/meta/1.1 |
| ordering | EP6PBzIq0meI-CrbjYiJ0zqO6cb5rvDBo0DrEP_4mzEY | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-31 05:26:04


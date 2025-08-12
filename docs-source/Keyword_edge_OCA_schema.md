---
layout: default  
title: Keyword edge  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Keyword edge  
**Description**: The keywords_edge.csv dataset is used in the RED-X application to define the connections (edges) between keyword nodes in the research network visualization. Each row in this dataset represents a pair of keywords that co-occurred in one or more studies. The strength of this connection—i.e., how frequently the two keywords appeared together—is recorded as the weight. This dataset, along with the keyword node data, helps the RED-X app render an interactive network plot that reveals relationships between concepts across historical research metadata. Users can explore how different keywords are interlinked, which can support discovery and thematic clustering.  
**Classification**: RDF212  
**Schema package SAID**: EJiCMhxrOZndvQQtBKbfE7FWfiZAaV_cJ8mX7k_jOYN0  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| from | from | The unique ID of the starting keyword node in the connection. |
| to | to | The unique ID of the target keyword node that is linked to the from node. |
| weight | weight | The number of studies where both keywords (from and to) co-occurred. |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Keyword edge | The keywords_edge.csv dataset is used in the RED-X application to define the connections (edges) between keyword nodes in the research network visualization. Each row in this dataset represents a pair of keywords that co-occurred in one or more studies. The strength of this connection—i.e., how frequently the two keywords appeared together—is recorded as the weight. This dataset, along with the keyword node data, helps the RED-X app render an interactive network plot that reveals relationships between concepts across historical research metadata. Users can explore how different keywords are interlinked, which can support discovery and thematic clustering. |

## Language-independent schema details

| Attribute | Sensitive | Unit | Type | Character encoding | Required entry | Format rule |
| --- | --- | --- | --- | --- | --- | --- |
| from | false |  | Numeric | utf-8 | true | ^\\d\+$ |
| to | false |  | Numeric | utf-8 | true | ^\\d\+$ |
| weight | false |  | Numeric | utf-8 | true | ^\\d\+$ |

## Language-specific schema details

### English

| Attribute | Label | Description | List |
| --- | --- | --- | --- |
| from | from | The unique ID of the starting keyword node in the connection. | Not a list |
| to | to | The unique ID of the target keyword node that is linked to the from node. | Not a list |
| weight | weight | The number of studies where both keywords (from and to) co-occurred. | Not a list |

## Schema SAIDs

**Capture base**: EIPGhhHuEV444bds9VWdD6H8BsU6SM3fAAJFPWr-XY7s

**Bundle**: EIdTdMBKfim9-Lif_88nYTuRc2mX5Jf4hug4OOvQW06E

**Package**: EJiCMhxrOZndvQQtBKbfE7FWfiZAaV_cJ8mX7k_jOYN0

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EJHpKCuJTcrRQoWvFGLX3QY9NbHGGOqo3YyAA2K86zkI | spec/overlays/character_encoding/1.1 |
| conformance | EJgMOyRhP_WAz40Da8upRblgkdXQTCAK54yFTzY2-qZF | spec/overlays/conformance/1.1 |
| format | EDCsAEyYYav_bn1XFLL5Me3nSHkumDMsOc089rphbT0I | spec/overlays/format/1.1 |
| information (eng) | ELmI2xXv2KZ6Lc7bJJZLtn7bXrGG6CiSeR8FTNUIJFSD | spec/overlays/information/1.1 |
| label (eng) | EGOaKJo3VylvcbQC075gsGZS2Wyz588epNBTYAhifNgT | spec/overlays/label/1.1 |
| meta (eng) | EFfO7x8Q_zJdfldwpZG6Bp96DceUR6zrjf8lgtPLxHoT | spec/overlays/meta/1.1 |
| ordering | EANxLAE0-kuJcZMSb1NFa-UoH2PLQDJ4gstD4TeAlLYt | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-29 03:44:48


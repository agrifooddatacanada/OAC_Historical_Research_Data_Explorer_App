---
layout: default  
title: Authors edges  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Authors edges  
**Description**: The authors_edge dataset is a critical component of the RED-X application\'s author network visualization. It represents the connections (edges) between different authors based on co-occurrence in the same research studies. Each row in this file denotes a link between two author nodes and the number of studies they share. This structure helps in mapping collaboration patterns and building the underlying graph for interactive visualization in the app.  
**Classification**: RDF212  
**Schema package SAID**: EBe-YU2ujVSMz2vprKOIu4KEiO8Vb8Yb8RqYYT_mpZUH  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| from | from | Unique ID of the source author node (referencing the id in authors_node) |
| to | to | Unique ID of the target author node (also referencing authors_node) |
| weight | weight | Number of studies both authors co-authored (edge strength) |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Authors edges | The authors_edge dataset is a critical component of the RED-X application\'s author network visualization. It represents the connections (edges) between different authors based on co-occurrence in the same research studies. Each row in this file denotes a link between two author nodes and the number of studies they share. This structure helps in mapping collaboration patterns and building the underlying graph for interactive visualization in the app. |

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
| from | from | Unique ID of the source author node (referencing the id in authors_node) | Not a list |
| to | to | Unique ID of the target author node (also referencing authors_node) | Not a list |
| weight | weight | Number of studies both authors co-authored (edge strength) | Not a list |

## Schema SAIDs

**Capture base**: EIPGhhHuEV444bds9VWdD6H8BsU6SM3fAAJFPWr-XY7s

**Bundle**: EOJmEuLmuKvSk_bRtfMfyiW-jLRdJ5T301QL0iKQovEP

**Package**: EBe-YU2ujVSMz2vprKOIu4KEiO8Vb8Yb8RqYYT_mpZUH

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EJHpKCuJTcrRQoWvFGLX3QY9NbHGGOqo3YyAA2K86zkI | spec/overlays/character_encoding/1.1 |
| conformance | EJgMOyRhP_WAz40Da8upRblgkdXQTCAK54yFTzY2-qZF | spec/overlays/conformance/1.1 |
| format | EDCsAEyYYav_bn1XFLL5Me3nSHkumDMsOc089rphbT0I | spec/overlays/format/1.1 |
| information (eng) | EBrC0x78fJurE6vd-oB6AOB-7aIMZkZQiNDWferB0FRY | spec/overlays/information/1.1 |
| label (eng) | EGOaKJo3VylvcbQC075gsGZS2Wyz588epNBTYAhifNgT | spec/overlays/label/1.1 |
| meta (eng) | EEh1X5zhnXX8rHnuTDzJweeUV38H3cLds9G2ckiaDpc7 | spec/overlays/meta/1.1 |
| ordering | EANxLAE0-kuJcZMSb1NFa-UoH2PLQDJ4gstD4TeAlLYt | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-29 04:15:52


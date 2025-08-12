---
layout: default  
title: Processed datasets in RED-X  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Processed datasets in RED-X  
**Description**: The processed_studies file contains a list of DOIs (Digital Object Identifiers) that have already been processed and cached within the RED-X app. It plays a crucial role in optimizing performance by allowing the application to skip reprocessing datasets that are already up-to-date. This helps reduce API load and improve app speed, especially when checking for new or updated studies from the Borealis Dataverse. In essence, it acts as a tracking list or checkpoint registry that the caching function (cache_raw_data()) uses to compare and filter out redundant operations.  
**Classification**: RDF212  
**Schema package SAID**: EEew5fwKdA3zkz_Y8CMSDnBFdJRAwZYGiuOtQhlypCnp  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| DOI | DOI | A unique persistent identifier for a research dataset. Used to verify whether the study has been processed. |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Processed datasets in RED-X | The processed_studies file contains a list of DOIs (Digital Object Identifiers) that have already been processed and cached within the RED-X app. It plays a crucial role in optimizing performance by allowing the application to skip reprocessing datasets that are already up-to-date. This helps reduce API load and improve app speed, especially when checking for new or updated studies from the Borealis Dataverse. In essence, it acts as a tracking list or checkpoint registry that the caching function (cache_raw_data()) uses to compare and filter out redundant operations. |

## Language-independent schema details

| Attribute | Sensitive | Unit | Type | Character encoding | Required entry | Format rule |
| --- | --- | --- | --- | --- | --- | --- |
| DOI | false |  | Numeric | utf-8 | true | ^doi:10\\\.\\d\{4,9\}/\[\-\.\_;\(\)/:Aa\-Zz0\-9\]\+$ |

## Language-specific schema details

### English

| Attribute | Label | Description | List |
| --- | --- | --- | --- |
| DOI | DOI | A unique persistent identifier for a research dataset. Used to verify whether the study has been processed. | Not a list |

## Schema SAIDs

**Capture base**: EBcWQH7PjQw6JiKG0X7FMFeUgMNv3SIstRf4MxhYzjeS

**Bundle**: EFCP0jgcA_VD-jSMX9Gt4NuJ8eQrzuG7CHnzM9SgGtwW

**Package**: EEew5fwKdA3zkz_Y8CMSDnBFdJRAwZYGiuOtQhlypCnp

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EGoNKnM8_drZa2f_5kGkkZJ9L2fjr6_2U-QQulUGApy2 | spec/overlays/character_encoding/1.1 |
| conformance | EKlhmc-JUaTyrcdWz1-Q1tAp1fbOMVfEhSdg6ZRsJ8j3 | spec/overlays/conformance/1.1 |
| format | EGcL2BlrJ835nNSF1EMXHarKYxuZUkw0kQhROK7Y1u-m | spec/overlays/format/1.1 |
| information (eng) | ENeQ3DsBK2jl_3M3lFdEfBqHnBQjBbr077hZxrCzwTvs | spec/overlays/information/1.1 |
| label (eng) | EHJ39Oui6MI53ZnlHyfzvoRQliiTqzjps9fdSOFcdsim | spec/overlays/label/1.1 |
| meta (eng) | EEzuZlJb1mq2A2dC5vT8wM2ukJOebZtEM8ykbWKg1Dh5 | spec/overlays/meta/1.1 |
| ordering | EE6DknXqe1M6vGkbzslM__g4NkBVq0e1oT6vm2AXSHvP | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-30 06:44:38


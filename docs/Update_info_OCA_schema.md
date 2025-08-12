---
layout: default  
title: Update_info  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Update_info  
**Description**: The update_info file stores the timestamp of the last successful data cache update in the RED-X application. It is used by the cache_raw_data() function to determine whether enough time (48 hours) has passed since the last update. If so, the app re-fetches metadata from Borealis; otherwise, it uses the cached data to reduce load time and avoid redundant API calls. This file serves as a lightweight control mechanism that ensures the app remains current while optimizing performance and bandwidth usage.  
**Classification**: RDF212  
**Schema package SAID**: EOVVy8DwCTq91031EUmNqY-5QGSBbVAbfTu-9ajscaEg  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| last_update | last_update | Timestamp of the last successful data caching operation in RED-X. |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Update_info | The update_info file stores the timestamp of the last successful data cache update in the RED-X application. It is used by the cache_raw_data() function to determine whether enough time (48 hours) has passed since the last update. If so, the app re-fetches metadata from Borealis; otherwise, it uses the cached data to reduce load time and avoid redundant API calls. This file serves as a lightweight control mechanism that ensures the app remains current while optimizing performance and bandwidth usage. |

## Language-independent schema details

| Attribute | Sensitive | Unit | Type | Character encoding | Required entry | Format rule |
| --- | --- | --- | --- | --- | --- | --- |
| last_update | false |  | DateTime | utf-8 | true | ^\(?:\\d\{4\}\)\-\(0\[1\-9\]\|1\[0\-2\]\)\-\(0\[1\-9\]\|\[12\]\\d\|3\[01\]\)T\(\[01\]\\d\|2\[0\-3\]\):\(\[0\-5\]\\d\):\(\[0\-5\]\\d\)Z$ |

## Language-specific schema details

### English

| Attribute | Label | Description | List |
| --- | --- | --- | --- |
| last_update | last_update | Timestamp of the last successful data caching operation in RED-X. | Not a list |

## Schema SAIDs

**Capture base**: EMJTU2IzXFesKF4ktRmp3w_QX2tJ4s_Rk_eqccbPccKr

**Bundle**: EKIXxIe1MeesMYdh1V5YOsZLCyzGz2cg5L0gbo8NZOWB

**Package**: EOVVy8DwCTq91031EUmNqY-5QGSBbVAbfTu-9ajscaEg

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EAdBmoSyflBvE4QBKbz8FR6OaB6y8RXTlS-0UgfS7SBN | spec/overlays/character_encoding/1.1 |
| conformance | EB9m1eX6i8xYblu68lYXN3_3FUyo_jazTL9eP4gXWfyS | spec/overlays/conformance/1.1 |
| format | EPxsNRUnFa-vr85brCI9PpfuK2NdaNg44BNf2ZEywnSc | spec/overlays/format/1.1 |
| information (eng) | EEpRI4L5bDIeVAg9Cu-qF08V_o2y1X36GnAV-uPaZeai | spec/overlays/information/1.1 |
| label (eng) | EOpq63LB1OUJgR0VYc-vM_46kM2HcFYPG5ok_aRUtPvT | spec/overlays/label/1.1 |
| meta (eng) | EK-1KGKUjqfJayB3u0TYxhQaZ605u1Z9BRO8eP3qIvAp | spec/overlays/meta/1.1 |
| ordering | EMY7PavL5JKR7_uTBQhCiseq3CHlvViA1QPjUs8vj2vx | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-29 04:40:40


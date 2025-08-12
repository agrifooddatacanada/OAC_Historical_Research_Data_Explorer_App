---
layout: default  
title: Research_data  
---

# Schema information
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

**Name**: Research_data  
**Description**: The research_data.csv dataset is a core component of the RED-X app and serves as the primary cache of research metadata retrieved from the Borealis Dataverse repository. It contains structured metadata for multiple agricultural and environmental studies, including fields such as Title, PublicationDate, Authors, Affiliations, Keywords, and Objectives. Each record is linked to a persistent identifier (DOI), along with institutional context like CollegeName and DepartmentName. These entries support the app’s dynamic search, visualization, and filtering features, and are stored in a local SQLite database to improve performance and reduce redundant API calls.  
**Classification**: RDF212  
**Schema package SAID**: EG6D6-mYDrAB1iivIHNnhqumcEbWaoyujJmSzlcunc-M  

## Schema quick view

| Attribute | Label | Description |
| --- | --- | --- |
| Title | Title | The title of the dataset or study as published in Borealis |
| PublicationDate | Publication Date | The date the dataset was made publicly available |
| Authors | Authors | A list of the individuals who contributed to or authored the dataset |
| Affiliations | Affiliations | The institutional affiliations of the authors, such as departments or research centers |
| Keywords | Keywords | Terms associated with the dataset for easier search and thematic classification |
| Objectives | Objectives | A brief description of the research goals or purpose of the dataset |
| Citation | Citation | Formal citation information for referencing the dataset in publications |
| PeriodCovered | Period Covered | The time frame during which data was collected (e.g., growing seasons, study period) |
| StudyLocation | Study Location | Geographic location where the study or data collection took place |
| Funder | Funder | Organizations or institutions that funded the research or data collection |
| FileList | File List | Names of files included in the dataset, such as .tab, .csv, or .txt files |
| DataLicense | Data License | Licensing information that defines how the dataset can be used or shared |
| DOI | DOI | The persistent identifier (Digital Object Identifier) that uniquely identifies the dataset |
| CollegeName | College Name | The college or broader organizational unit associated with the dataset |
| DepartmentName | Department Name | The specific department, lab, or research center responsible for the dataset |

## International schema information

| Language | Name | Description |
| --- | --- | --- |
| English | Research_data | The research_data.csv dataset is a core component of the RED-X app and serves as the primary cache of research metadata retrieved from the Borealis Dataverse repository. It contains structured metadata for multiple agricultural and environmental studies, including fields such as Title, PublicationDate, Authors, Affiliations, Keywords, and Objectives. Each record is linked to a persistent identifier (DOI), along with institutional context like CollegeName and DepartmentName. These entries support the app’s dynamic search, visualization, and filtering features, and are stored in a local SQLite database to improve performance and reduce redundant API calls. |

## Language-independent schema details

| Attribute | Sensitive | Unit | Type | Character encoding | Required entry | Format rule |
| --- | --- | --- | --- | --- | --- | --- |
| Title | false |  | Text | utf-8 | true |  |
| PublicationDate | false |  | DateTime | utf-8 | true |  |
| Authors | false |  | Text | utf-8 | true |  |
| Affiliations | false |  | Text | utf-8 | false |  |
| Keywords | false |  | Text | utf-8 | true |  |
| Objectives | false |  | Text | utf-8 | false |  |
| Citation | false |  | Text | utf-8 | false |  |
| PeriodCovered | false |  | Text | utf-8 | false |  |
| StudyLocation | false |  | Text | utf-8 | false |  |
| Funder | false |  | Text | utf-8 | false |  |
| FileList | false |  | Text | utf-8 | false |  |
| DataLicense | false |  | Text | utf-8 | false |  |
| DOI | false |  | Text | utf-8 | true | ^doi:10\\\.\\d\{4,9\}/\[\-\.\_;\(\)/:Aa\-Zz0\-9\]\+$  |
| CollegeName | false |  | Text | utf-8 | true |  |
| DepartmentName | false |  | Text | utf-8 | true |  |

## Language-specific schema details

### English

| Attribute | Label | Description | List |
| --- | --- | --- | --- |
| Title | Title | The title of the dataset or study as published in Borealis | Not a list |
| PublicationDate | Publication Date | The date the dataset was made publicly available | Not a list |
| Authors | Authors | A list of the individuals who contributed to or authored the dataset | Not a list |
| Affiliations | Affiliations | The institutional affiliations of the authors, such as departments or research centers | Not a list |
| Keywords | Keywords | Terms associated with the dataset for easier search and thematic classification | Not a list |
| Objectives | Objectives | A brief description of the research goals or purpose of the dataset | Not a list |
| Citation | Citation | Formal citation information for referencing the dataset in publications | Not a list |
| PeriodCovered | Period Covered | The time frame during which data was collected (e.g., growing seasons, study period) | Not a list |
| StudyLocation | Study Location | Geographic location where the study or data collection took place | Not a list |
| Funder | Funder | Organizations or institutions that funded the research or data collection | Not a list |
| FileList | File List | Names of files included in the dataset, such as .tab, .csv, or .txt files | Not a list |
| DataLicense | Data License | Licensing information that defines how the dataset can be used or shared | Not a list |
| DOI | DOI | The persistent identifier (Digital Object Identifier) that uniquely identifies the dataset | Not a list |
| CollegeName | College Name | The college or broader organizational unit associated with the dataset | Not a list |
| DepartmentName | Department Name | The specific department, lab, or research center responsible for the dataset | Not a list |

## Schema SAIDs

**Capture base**: EAbbWiPPVbr8eHX9Vy0zghNVzfOtHScaSTjyy39DjNFq

**Bundle**: EOVr6xIUajAON8if09vlXAvWOhVp8tsbOYUGVMKOYtAc

**Package**: EG6D6-mYDrAB1iivIHNnhqumcEbWaoyujJmSzlcunc-M

| Layer | SAID | Type |
| --- | --- | --- |
| character_encoding | EFF_SIriN5fvG0dOuqO0ArKsulc-k4jfsz82RFosFbiD | spec/overlays/character_encoding/1.1 |
| conformance | ECNSoB8U31gxNcyHJfxk6XFDD_9flElc_gH6kCE8IUdB | spec/overlays/conformance/1.1 |
| format | EFr_apY3LgDd9Zyns3alJUVyLxapP5NSKsphb7_z_a79 | spec/overlays/format/1.1 |
| information (eng) | EO9iqg0aCp32hsVB7qLRRQ6EwgTwe-FXhrBhWDO_v8c8 | spec/overlays/information/1.1 |
| label (eng) | EEQSRNYUSLktOqYLha2udTs5HzBmWjpl3hNF0ylrmlV- | spec/overlays/label/1.1 |
| meta (eng) | EAyt9CmbKnc_xBwJ1TqN6nnjDYFhCd5pbgw1-peUkIQR | spec/overlays/meta/1.1 |
| ordering | EG4ysAjmw2iv6NK7OhkHtV9167W5qMimERnJl9OgKoeB | community/overlays/adc/ordering/1.1 |

**Date created**: 2025-07-31 05:29:10


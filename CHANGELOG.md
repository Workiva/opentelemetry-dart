# Changelog

## [0.18.6](https://github.com/Workiva/opentelemetry-dart/tree/0.18.6) (2024-08-15)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.18.5...0.18.6)

**Merged pull requests:**

- Make registerGlobalContextManager public API [\#183](https://github.com/Workiva/opentelemetry-dart/pull/183) ([jonathancampbell-wk](https://github.com/jonathancampbell-wk))
- O11Y-4831: Use test URL in test [\#181](https://github.com/Workiva/opentelemetry-dart/pull/181) ([kennytrytek-wf](https://github.com/kennytrytek-wf))

## [0.18.5](https://github.com/Workiva/opentelemetry-dart/tree/0.18.5) (2024-08-01)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.18.4...0.18.5)

**Merged pull requests:**

- PPI-165 : fix timestamp rounding issues and expose helpers for high res timestamps [\#179](https://github.com/Workiva/opentelemetry-dart/pull/179) ([blakeroberts-wk](https://github.com/blakeroberts-wk))
- update changelog [\#178](https://github.com/Workiva/opentelemetry-dart/pull/178) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.18.4](https://github.com/Workiva/opentelemetry-dart/tree/0.18.4) (2024-07-18)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.18.3...0.18.4)

**Closed issues:**

- \[Question\] What is correct way to call Context.current.span now? [\#173](https://github.com/Workiva/opentelemetry-dart/issues/173)
- RecordException doesn't capture Exception as Event [\#152](https://github.com/Workiva/opentelemetry-dart/issues/152)

**Merged pull requests:**

- add cross-cutting context api functions [\#176](https://github.com/Workiva/opentelemetry-dart/pull/176) ([blakeroberts-wk](https://github.com/blakeroberts-wk))
- Update CODEOWNERS [\#175](https://github.com/Workiva/opentelemetry-dart/pull/175) ([tylerrinnan-wf](https://github.com/tylerrinnan-wf))
- Exception as event [\#160](https://github.com/Workiva/opentelemetry-dart/pull/160) ([mikebosland](https://github.com/mikebosland))
- Improve pub.dev PUB POINTS 100-\>130 [\#159](https://github.com/Workiva/opentelemetry-dart/pull/159) ([mikebosland](https://github.com/mikebosland))

## [0.18.3](https://github.com/Workiva/opentelemetry-dart/tree/0.18.3) (2024-05-23)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.18.2...0.18.3)

**Closed issues:**

- I can't find `withContext` and `setSpan` from README [\#162](https://github.com/Workiva/opentelemetry-dart/issues/162)

**Merged pull requests:**

- O11Y-4632 Release 0.18.3 [\#171](https://github.com/Workiva/opentelemetry-dart/pull/171) ([changliu-wk](https://github.com/changliu-wk))
- O11Y-4623: Update Context API examples in opentelemetry-dart README [\#170](https://github.com/Workiva/opentelemetry-dart/pull/170) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-4010: Add ContextManager for Context [\#167](https://github.com/Workiva/opentelemetry-dart/pull/167) ([changliu-wk](https://github.com/changliu-wk))
- Replace mockito with mocktail [\#165](https://github.com/Workiva/opentelemetry-dart/pull/165) ([sourcegraph-wk](https://github.com/sourcegraph-wk))
- Update GHA publishing steps [\#164](https://github.com/Workiva/opentelemetry-dart/pull/164) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- Allow a custom time provider in TracerProviderBase [\#158](https://github.com/Workiva/opentelemetry-dart/pull/158) ([mikebosland](https://github.com/mikebosland))
- Allow custom timestamps to be used on Span.end\(\) [\#115](https://github.com/Workiva/opentelemetry-dart/pull/115) ([rafaelring](https://github.com/rafaelring))

## [0.18.2](https://github.com/Workiva/opentelemetry-dart/tree/0.18.2) (2024-04-01)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.18.1...0.18.2)

**Closed issues:**

- PreFlight request support [\#154](https://github.com/Workiva/opentelemetry-dart/issues/154)

**Merged pull requests:**

- expose sdk.Attributes [\#157](https://github.com/Workiva/opentelemetry-dart/pull/157) ([yuzurihaaa](https://github.com/yuzurihaaa))
- O11Y-4317: update generated mocks and format project [\#155](https://github.com/Workiva/opentelemetry-dart/pull/155) ([blakeroberts-wk](https://github.com/blakeroberts-wk))
- O11Y-4273: Version Bump [\#151](https://github.com/Workiva/opentelemetry-dart/pull/151) ([kennytrytek-wf](https://github.com/kennytrytek-wf))
- O11Y-4278: Add publishing note [\#149](https://github.com/Workiva/opentelemetry-dart/pull/149) ([kennytrytek-wf](https://github.com/kennytrytek-wf))

## [0.18.1](https://github.com/Workiva/opentelemetry-dart/tree/0.18.1) (2024-02-26)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.18.0...0.18.1)

**Closed issues:**

- Process crashes when no collector is running [\#147](https://github.com/Workiva/opentelemetry-dart/issues/147)
- 0.18.0 release to pub.dev? [\#142](https://github.com/Workiva/opentelemetry-dart/issues/142)

**Merged pull requests:**

- Show log and keep running on export failure [\#148](https://github.com/Workiva/opentelemetry-dart/pull/148) ([tapih](https://github.com/tapih))
- Bump the pub group with 1 update [\#145](https://github.com/Workiva/opentelemetry-dart/pull/145) ([dependabot[bot]](https://github.com/apps/dependabot))

## [0.18.0](https://github.com/Workiva/opentelemetry-dart/tree/0.18.0) (2024-01-18)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.17.0...0.18.0)

**Closed issues:**

- Support for Events? [\#116](https://github.com/Workiva/opentelemetry-dart/issues/116)

**Merged pull requests:**

- Bump the pub group with 2 updates [\#144](https://github.com/Workiva/opentelemetry-dart/pull/144) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump the pub group with 1 update [\#143](https://github.com/Workiva/opentelemetry-dart/pull/143) ([dependabot[bot]](https://github.com/apps/dependabot))
- O11Y-3814: version bump [\#141](https://github.com/Workiva/opentelemetry-dart/pull/141) ([kennytrytek-wf](https://github.com/kennytrytek-wf))
- O11Y-3814: Support Dart 2 and Dart 3 [\#140](https://github.com/Workiva/opentelemetry-dart/pull/140) ([kennytrytek-wf](https://github.com/kennytrytek-wf))
- O11Y-3736: opentelemetry-dart: Deprecate MeterSharedState [\#139](https://github.com/Workiva/opentelemetry-dart/pull/139) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-3733: opentelemetry-dart: Implement Improvements to Timer in BatchSpanProcessor [\#137](https://github.com/Workiva/opentelemetry-dart/pull/137) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- Implemented Span.addEvent and added tests for it [\#136](https://github.com/Workiva/opentelemetry-dart/pull/136) ([baskillen](https://github.com/baskillen))
- Bump the github-actions group with 1 update [\#132](https://github.com/Workiva/opentelemetry-dart/pull/132) ([dependabot[bot]](https://github.com/apps/dependabot))

## [0.17.0](https://github.com/Workiva/opentelemetry-dart/tree/0.17.0) (2023-11-10)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.16.2...0.17.0)

**Merged pull requests:**

- opentelemetry-dart 0.17.0 [\#135](https://github.com/Workiva/opentelemetry-dart/pull/135) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-3369: Migrate opentelemetry-dart to GHA [\#134](https://github.com/Workiva/opentelemetry-dart/pull/134) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- Bump the pub group with 1 update [\#133](https://github.com/Workiva/opentelemetry-dart/pull/133) ([dependabot[bot]](https://github.com/apps/dependabot))
- Dart 2.19 [\#131](https://github.com/Workiva/opentelemetry-dart/pull/131) ([sourcegraph-wk](https://github.com/sourcegraph-wk))
- O11Y-3369: Migrate opentelemetry-dart to GHA [\#126](https://github.com/Workiva/opentelemetry-dart/pull/126) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-3138: Update deprecation messages [\#122](https://github.com/Workiva/opentelemetry-dart/pull/122) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- Rollout Analyzer 5 [\#120](https://github.com/Workiva/opentelemetry-dart/pull/120) ([sourcegraph-wk](https://github.com/sourcegraph-wk))
- O11Y-3138: Improve Adherence to Specification [\#118](https://github.com/Workiva/opentelemetry-dart/pull/118) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.16.2](https://github.com/Workiva/opentelemetry-dart/tree/0.16.2) (2023-07-11)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.16.1...0.16.2)

**Merged pull requests:**

- O11Y-3136 : update protoc to v20.0.1 [\#113](https://github.com/Workiva/opentelemetry-dart/pull/113) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.16.1](https://github.com/Workiva/opentelemetry-dart/tree/0.16.1) (2023-05-25)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.16.0...0.16.1)

**Merged pull requests:**

- Add dependency for meta to pubspec.yaml [\#111](https://github.com/Workiva/opentelemetry-dart/pull/111) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.16.0](https://github.com/Workiva/opentelemetry-dart/tree/0.16.0) (2023-05-25)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.14.4...0.16.0)

**Closed issues:**

- MeterProvider doesn't yet support resources [\#87](https://github.com/Workiva/opentelemetry-dart/issues/87)

**Merged pull requests:**

- Move W3CTraceContextPropagator to API package [\#109](https://github.com/Workiva/opentelemetry-dart/pull/109) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-2859: Disable code coverage comments on pull requests [\#108](https://github.com/Workiva/opentelemetry-dart/pull/108) ([dustinlessard-wf](https://github.com/dustinlessard-wf))
- Update dart dependencies [\#106](https://github.com/Workiva/opentelemetry-dart/pull/106) ([sourcegraph-wk](https://github.com/sourcegraph-wk))
- O11Y-2792: Update action versions [\#105](https://github.com/Workiva/opentelemetry-dart/pull/105) ([changliu-wk](https://github.com/changliu-wk))
- Fix syntax errors in README example code. [\#104](https://github.com/Workiva/opentelemetry-dart/pull/104) ([scidev20](https://github.com/scidev20))
- Pin mockito 5 [\#103](https://github.com/Workiva/opentelemetry-dart/pull/103) ([sourcegraph-wk](https://github.com/sourcegraph-wk))
- Extended exporter with a headers map for authorization [\#102](https://github.com/Workiva/opentelemetry-dart/pull/102) ([v-shemet](https://github.com/v-shemet))
- O11Y-2370: Report Code Coverage on PRs [\#96](https://github.com/Workiva/opentelemetry-dart/pull/96) ([dustinlessard-wf](https://github.com/dustinlessard-wf))
- O11Y-2256 : Resource can be passed into MeterProvider [\#90](https://github.com/Workiva/opentelemetry-dart/pull/90) ([dustinlessard-wf](https://github.com/dustinlessard-wf))

## [0.14.4](https://github.com/Workiva/opentelemetry-dart/tree/0.14.4) (2022-11-10)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.15.1...0.14.4)

## [0.15.1](https://github.com/Workiva/opentelemetry-dart/tree/0.15.1) (2022-11-08)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.15.0...0.15.1)

**Closed issues:**

- We need a pull request template [\#82](https://github.com/Workiva/opentelemetry-dart/issues/82)
- SDK.MetricsOptions.setUnits lack implementation [\#77](https://github.com/Workiva/opentelemetry-dart/issues/77)
- MetricOptions.setDescription lacks implementation [\#76](https://github.com/Workiva/opentelemetry-dart/issues/76)

**Merged pull requests:**

- Update http to allow 0.13.0 [\#91](https://github.com/Workiva/opentelemetry-dart/pull/91) ([robbecker-wf](https://github.com/robbecker-wf))
- O11Y-2352 : added missing dependency [\#89](https://github.com/Workiva/opentelemetry-dart/pull/89) ([dustinlessard-wf](https://github.com/dustinlessard-wf))
- New Template [\#84](https://github.com/Workiva/opentelemetry-dart/pull/84) ([danrick-wk](https://github.com/danrick-wk))
- O11Y-2154 : Add MeterProvider classes [\#78](https://github.com/Workiva/opentelemetry-dart/pull/78) ([dustinlessard-wf](https://github.com/dustinlessard-wf))

## [0.15.0](https://github.com/Workiva/opentelemetry-dart/tree/0.15.0) (2022-09-14)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/1.0.0...0.15.0)

## [1.0.0](https://github.com/Workiva/opentelemetry-dart/tree/1.0.0) (2022-09-13)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.14.3...1.0.0)

**Closed issues:**

- Global setup code should be exposed via the api not via the sdk [\#80](https://github.com/Workiva/opentelemetry-dart/issues/80)

**Merged pull requests:**

- O11Y-2238 moved to api [\#81](https://github.com/Workiva/opentelemetry-dart/pull/81) ([danrick-wk](https://github.com/danrick-wk))

## [0.14.3](https://github.com/Workiva/opentelemetry-dart/tree/0.14.3) (2022-08-18)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.14.2...0.14.3)

**Closed issues:**

- Repo lacks assets helpful to contributors [\#69](https://github.com/Workiva/opentelemetry-dart/issues/69)
- Pub publishing indicates warning related to missing changelog [\#67](https://github.com/Workiva/opentelemetry-dart/issues/67)
- opentelemetry-dart should expose CI results to contributors [\#64](https://github.com/Workiva/opentelemetry-dart/issues/64)

**Merged pull requests:**

- O11Y-2149: Resolve changelog warning for publishing to public pub server [\#68](https://github.com/Workiva/opentelemetry-dart/pull/68) ([dustinlessard-wf](https://github.com/dustinlessard-wf))

## [0.14.2](https://github.com/Workiva/opentelemetry-dart/tree/0.14.2) (2022-08-17)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.14.1...0.14.2)

**Merged pull requests:**

- O11Y-2150 : Opentelemetry-dart lacks assets helpful to contributors [\#70](https://github.com/Workiva/opentelemetry-dart/pull/70) ([dustinlessard-wf](https://github.com/dustinlessard-wf))

## [0.14.1](https://github.com/Workiva/opentelemetry-dart/tree/0.14.1) (2022-06-14)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.14.0...0.14.1)

**Merged pull requests:**

- O11Y-1873: Adjust copyright information in OpenTelemetryDart [\#62](https://github.com/Workiva/opentelemetry-dart/pull/62) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.14.0](https://github.com/Workiva/opentelemetry-dart/tree/0.14.0) (2022-06-03)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.13.0...0.14.0)

**Merged pull requests:**

- Add Resource Attribute for Deployment Environment [\#61](https://github.com/Workiva/opentelemetry-dart/pull/61) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.13.0](https://github.com/Workiva/opentelemetry-dart/tree/0.13.0) (2022-06-03)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.12.1...0.13.0)

**Merged pull requests:**

- `trace` shouldn't alter the return type of the function being traced [\#58](https://github.com/Workiva/opentelemetry-dart/pull/58) ([jasonaguilon-wf](https://github.com/jasonaguilon-wf))

## [0.12.1](https://github.com/Workiva/opentelemetry-dart/tree/0.12.1) (2022-05-26)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.12.0...0.12.1)

**Merged pull requests:**

- O11Y-1842 : commit protobuf generated code [\#60](https://github.com/Workiva/opentelemetry-dart/pull/60) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.12.0](https://github.com/Workiva/opentelemetry-dart/tree/0.12.0) (2022-05-26)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.11.1...0.12.0)

**Merged pull requests:**

- O11Y-1784: Tracing attributes should follow naming convention guidelines [\#54](https://github.com/Workiva/opentelemetry-dart/pull/54) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.11.1](https://github.com/Workiva/opentelemetry-dart/tree/0.11.1) (2022-05-25)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.11.0...0.11.1)

**Merged pull requests:**

- O11Y-1770: Add required files to opentelemetry-dart repo for OSS [\#51](https://github.com/Workiva/opentelemetry-dart/pull/51) ([keruitan-wk](https://github.com/keruitan-wk))

## [0.11.0](https://github.com/Workiva/opentelemetry-dart/tree/0.11.0) (2022-05-25)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.10.0...0.11.0)

**Merged pull requests:**

- O11Y-1750: implement spanLinks [\#56](https://github.com/Workiva/opentelemetry-dart/pull/56) ([changliu-wk](https://github.com/changliu-wk))

## [0.10.0](https://github.com/Workiva/opentelemetry-dart/tree/0.10.0) (2022-05-11)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.9.4...0.10.0)

**Merged pull requests:**

- O11Y-1489: Update span processors to match otel spec [\#59](https://github.com/Workiva/opentelemetry-dart/pull/59) ([keruitan-wk](https://github.com/keruitan-wk))

## [0.9.4](https://github.com/Workiva/opentelemetry-dart/tree/0.9.4) (2022-05-10)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.9.3...0.9.4)

**Merged pull requests:**

- O11Y-1804: Update Dart Dockerfile to use new Dart image [\#57](https://github.com/Workiva/opentelemetry-dart/pull/57) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.9.3](https://github.com/Workiva/opentelemetry-dart/tree/0.9.3) (2022-05-09)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.9.2...0.9.3)

**Merged pull requests:**

- O11Y-1748: OpenTelemetry Dart: Implement forceFlush for SpanExporters [\#55](https://github.com/Workiva/opentelemetry-dart/pull/55) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.9.2](https://github.com/Workiva/opentelemetry-dart/tree/0.9.2) (2022-05-06)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.9.1...0.9.2)

**Merged pull requests:**

- Replace deprecated commands with new dart commands [\#49](https://github.com/Workiva/opentelemetry-dart/pull/49) ([sourcegraph-wk](https://github.com/sourcegraph-wk))

## [0.9.1](https://github.com/Workiva/opentelemetry-dart/tree/0.9.1) (2022-05-04)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.9.0...0.9.1)

**Merged pull requests:**

- O11Y 1771 Update CODEOWNERS file [\#52](https://github.com/Workiva/opentelemetry-dart/pull/52) ([sourcegraph-wk](https://github.com/sourcegraph-wk))

## [0.9.0](https://github.com/Workiva/opentelemetry-dart/tree/0.9.0) (2022-04-29)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.8.0...0.9.0)

**Merged pull requests:**

- O11Y-1749: OpenTelemetry Dart: Complete Implementation of SpanKind [\#50](https://github.com/Workiva/opentelemetry-dart/pull/50) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.8.0](https://github.com/Workiva/opentelemetry-dart/tree/0.8.0) (2022-04-27)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.7.0...0.8.0)

**Merged pull requests:**

- O11Y-1508: Change Span to use high resolution time instead of DateTime.now\(\) [\#39](https://github.com/Workiva/opentelemetry-dart/pull/39) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.7.0](https://github.com/Workiva/opentelemetry-dart/tree/0.7.0) (2022-04-26)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.6.0...0.7.0)

**Merged pull requests:**

- O11Y-1694: move attributes and resource to sdk [\#47](https://github.com/Workiva/opentelemetry-dart/pull/47) ([changliu-wk](https://github.com/changliu-wk))

## [0.6.0](https://github.com/Workiva/opentelemetry-dart/tree/0.6.0) (2022-04-18)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.5.0...0.6.0)

**Merged pull requests:**

- O11Y-1709: Move Sampler to SDK [\#48](https://github.com/Workiva/opentelemetry-dart/pull/48) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.5.0](https://github.com/Workiva/opentelemetry-dart/tree/0.5.0) (2022-04-15)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.4.1...0.5.0)

**Merged pull requests:**

- O11Y-1665: Stub out remaining interface methods in opentelemetry-dart [\#43](https://github.com/Workiva/opentelemetry-dart/pull/43) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.4.1](https://github.com/Workiva/opentelemetry-dart/tree/0.4.1) (2022-04-14)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.4.0...0.4.1)

**Merged pull requests:**

- O11Y-1716 : add skynet.yaml [\#46](https://github.com/Workiva/opentelemetry-dart/pull/46) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.4.0](https://github.com/Workiva/opentelemetry-dart/tree/0.4.0) (2022-04-13)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.3.0...0.4.0)

**Merged pull requests:**

- O11Y-1631: add SpanLimits, implement maxNumAttributes and maxNumAttributeLength [\#42](https://github.com/Workiva/opentelemetry-dart/pull/42) ([changliu-wk](https://github.com/changliu-wk))

## [0.3.0](https://github.com/Workiva/opentelemetry-dart/tree/0.3.0) (2022-04-13)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.2.0...0.3.0)

**Merged pull requests:**

- O11Y-1679: Move Tracer.trace out of Tracer class/interface [\#44](https://github.com/Workiva/opentelemetry-dart/pull/44) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.2.0](https://github.com/Workiva/opentelemetry-dart/tree/0.2.0) (2022-03-11)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.21...0.2.0)

**Merged pull requests:**

- O11Y-1504: wo11y-dart tracer.trace spans don't end until the parent span ends [\#41](https://github.com/Workiva/opentelemetry-dart/pull/41) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.21](https://github.com/Workiva/opentelemetry-dart/tree/0.1.21) (2022-02-24)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.20...0.1.21)

**Merged pull requests:**

- Run semver report as part of CI [\#40](https://github.com/Workiva/opentelemetry-dart/pull/40) ([jayudey-wf](https://github.com/jayudey-wf))

## [0.1.20](https://github.com/Workiva/opentelemetry-dart/tree/0.1.20) (2022-02-24)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.19...0.1.20)

**Merged pull requests:**

- O11Y-1528 : update sdk to use api where possible [\#36](https://github.com/Workiva/opentelemetry-dart/pull/36) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.1.19](https://github.com/Workiva/opentelemetry-dart/tree/0.1.19) (2022-02-24)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.18...0.1.19)

**Merged pull requests:**

- Temporarily disable the mockito builder for better build perf [\#38](https://github.com/Workiva/opentelemetry-dart/pull/38) ([sourcegraph-wk](https://github.com/sourcegraph-wk))

## [0.1.18](https://github.com/Workiva/opentelemetry-dart/tree/0.1.18) (2022-01-12)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.17...0.1.18)

**Merged pull requests:**

- Widen ranges of fixnum and protobuf [\#35](https://github.com/Workiva/opentelemetry-dart/pull/35) ([evanweible-wf](https://github.com/evanweible-wf))

## [0.1.17](https://github.com/Workiva/opentelemetry-dart/tree/0.1.17) (2022-01-06)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.16...0.1.17)

**Merged pull requests:**

- O11Y-1356: Add trace\(\) helper for opentelemetry dart [\#34](https://github.com/Workiva/opentelemetry-dart/pull/34) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.16](https://github.com/Workiva/opentelemetry-dart/tree/0.1.16) (2021-12-20)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.15...0.1.16)

**Merged pull requests:**

- O11Y-1293 : include span attributes in collector exporter [\#32](https://github.com/Workiva/opentelemetry-dart/pull/32) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.1.15](https://github.com/Workiva/opentelemetry-dart/tree/0.1.15) (2021-12-17)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.14...0.1.15)

**Merged pull requests:**

- Raise Max Versions [\#33](https://github.com/Workiva/opentelemetry-dart/pull/33) ([sourcegraph-wk](https://github.com/sourcegraph-wk))

## [0.1.14](https://github.com/Workiva/opentelemetry-dart/tree/0.1.14) (2021-12-10)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.13...0.1.14)

**Merged pull requests:**

- O11Y-1027: Parent Based Sampling [\#30](https://github.com/Workiva/opentelemetry-dart/pull/30) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.13](https://github.com/Workiva/opentelemetry-dart/tree/0.1.13) (2021-11-22)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.12...0.1.13)

**Merged pull requests:**

- RED-4673 : add aviary.yaml [\#29](https://github.com/Workiva/opentelemetry-dart/pull/29) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.1.12](https://github.com/Workiva/opentelemetry-dart/tree/0.1.12) (2021-11-16)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.11...0.1.12)

**Merged pull requests:**

- Expose StatusCode API [\#27](https://github.com/Workiva/opentelemetry-dart/pull/27) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.11](https://github.com/Workiva/opentelemetry-dart/tree/0.1.11) (2021-11-15)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.10...0.1.11)

**Merged pull requests:**

- O11Y-1291 : allow for multiple tracers [\#26](https://github.com/Workiva/opentelemetry-dart/pull/26) ([blakeroberts-wk](https://github.com/blakeroberts-wk))

## [0.1.10](https://github.com/Workiva/opentelemetry-dart/tree/0.1.10) (2021-11-15)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.9...0.1.10)

**Merged pull requests:**

- Add global registration documentation [\#25](https://github.com/Workiva/opentelemetry-dart/pull/25) ([garrickpeterson-wf](https://github.com/garrickpeterson-wf))

## [0.1.9](https://github.com/Workiva/opentelemetry-dart/tree/0.1.9) (2021-11-11)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.8...0.1.9)

**Merged pull requests:**

- API For Registering Global Instance [\#24](https://github.com/Workiva/opentelemetry-dart/pull/24) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.8](https://github.com/Workiva/opentelemetry-dart/tree/0.1.8) (2021-11-01)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.7...0.1.8)

**Merged pull requests:**

- Fix Version Make Target [\#23](https://github.com/Workiva/opentelemetry-dart/pull/23) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.7](https://github.com/Workiva/opentelemetry-dart/tree/0.1.7) (2021-10-28)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.6...0.1.7)

**Merged pull requests:**

- Expose Attribute SDK [\#22](https://github.com/Workiva/opentelemetry-dart/pull/22) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.6](https://github.com/Workiva/opentelemetry-dart/tree/0.1.6) (2021-10-28)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.5...0.1.6)

**Merged pull requests:**

- Remove Text Map Propagators [\#21](https://github.com/Workiva/opentelemetry-dart/pull/21) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.5](https://github.com/Workiva/opentelemetry-dart/tree/0.1.5) (2021-10-21)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.4...0.1.5)

**Merged pull requests:**

- O11Y-1045: opentelemetry-dart must manage different contexts for async code [\#19](https://github.com/Workiva/opentelemetry-dart/pull/19) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.1.4](https://github.com/Workiva/opentelemetry-dart/tree/0.1.4) (2021-10-06)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.3...0.1.4)

**Merged pull requests:**

- Pin protoc\_plugin to 19.3.1 to account for SDK 2.11 [\#18](https://github.com/Workiva/opentelemetry-dart/pull/18) ([tylersnavely-wf](https://github.com/tylersnavely-wf))

## [0.1.3](https://github.com/Workiva/opentelemetry-dart/tree/0.1.3) (2021-10-05)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.2...0.1.3)

**Merged pull requests:**

- O11Y-1208: Direct commit release version [\#17](https://github.com/Workiva/opentelemetry-dart/pull/17) ([tylersnavely-wf](https://github.com/tylersnavely-wf))
- O11Y-1208: Release every pull [\#15](https://github.com/Workiva/opentelemetry-dart/pull/15) ([tylersnavely-wf](https://github.com/tylersnavely-wf))

## [0.1.2](https://github.com/Workiva/opentelemetry-dart/tree/0.1.2) (2021-10-04)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.1...0.1.2)

**Merged pull requests:**

- O11Y-1208: Set pubspec.yaml version automatically [\#14](https://github.com/Workiva/opentelemetry-dart/pull/14) ([tylersnavely-wf](https://github.com/tylersnavely-wf))

## [0.1.1](https://github.com/Workiva/opentelemetry-dart/tree/0.1.1) (2021-10-04)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.1.0...0.1.1)

**Merged pull requests:**

- Readme step by step [\#9](https://github.com/Workiva/opentelemetry-dart/pull/9) ([tylersnavely-wf](https://github.com/tylersnavely-wf))

## [0.1.0](https://github.com/Workiva/opentelemetry-dart/tree/0.1.0) (2021-10-01)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.0.2...0.1.0)

**Merged pull requests:**

- O11Y-1019: Inject and Extract context from a message to feed into span creation [\#12](https://github.com/Workiva/opentelemetry-dart/pull/12) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- Raise the Dart SDK minimum to at least 2.11.0 [\#11](https://github.com/Workiva/opentelemetry-dart/pull/11) ([sourcegraph-wk](https://github.com/sourcegraph-wk))
- O11Y-994: OTEL Dart: Implement Tracer Provider API [\#10](https://github.com/Workiva/opentelemetry-dart/pull/10) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-989: Functionality to set attributes on spans [\#3](https://github.com/Workiva/opentelemetry-dart/pull/3) ([michaelyeager-wf](https://github.com/michaelyeager-wf))

## [0.0.2](https://github.com/Workiva/opentelemetry-dart/tree/0.0.2) (2021-08-27)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/0.0.1...0.0.2)

**Merged pull requests:**

- Fix release validation errors [\#8](https://github.com/Workiva/opentelemetry-dart/pull/8) ([tylersnavely-wf](https://github.com/tylersnavely-wf))

## [0.0.1](https://github.com/Workiva/opentelemetry-dart/tree/0.0.1) (2021-08-27)

[Full Changelog](https://github.com/Workiva/opentelemetry-dart/compare/709cab960f612c6aff4ce17158e4c7929f268f4a...0.0.1)

**Merged pull requests:**

- O11Y-1062: Create version 0.0.1 [\#7](https://github.com/Workiva/opentelemetry-dart/pull/7) ([tylersnavely-wf](https://github.com/tylersnavely-wf))
- O11Y-992: OTEL Dart: Implement OTLP HTTP Reporter [\#6](https://github.com/Workiva/opentelemetry-dart/pull/6) ([tylersnavely-wf](https://github.com/tylersnavely-wf))
- O11Y-990: Set span status [\#5](https://github.com/Workiva/opentelemetry-dart/pull/5) ([michaelyeager-wf](https://github.com/michaelyeager-wf))
- O11Y-993: OTEL Dart: Implement OTLP Console Reporter [\#4](https://github.com/Workiva/opentelemetry-dart/pull/4) ([tylersnavely-wf](https://github.com/tylersnavely-wf))
- O11Y-988: Record Spans [\#2](https://github.com/Workiva/opentelemetry-dart/pull/2) ([tylersnavely-wf](https://github.com/tylersnavely-wf))
- Initial branch [\#1](https://github.com/Workiva/opentelemetry-dart/pull/1) ([tylersnavely-wf](https://github.com/tylersnavely-wf))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*

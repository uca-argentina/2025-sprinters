# Ingenieria del Software II - Template

![GHA Status](https://github.com/uca-argentina/2025-sprinters/actions/workflows/GHA.yml/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/uca-argentina/2025-sprinters/badge.svg?branch=master)](https://coveralls.io/github/uca-argentina/2025-sprinters?branch=master)

## Metacello

```smalltalk
Metacello new
   baseline: 'IngSoft2';
   githubUser: 'uca-argentina' project: '2025-sprinters' commitish: 'master' path: 'repository';
   load: 'development'.
```

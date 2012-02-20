# Beggar [![Build Status](https://secure.travis-ci.org/bkzl/beggar.png)](http://travis-ci.org/bkzl/beggar)

## Description

Beggar is a tool for generating time reports from your Basecamp account

Example output:

    Current month
    Working days progress: 78%
    Worked hours ratio:    140.0h, -12.0h
    Salary ratio:          5320.0 zł, -456.0 zł

### Installation

Install it like any ruby gem

    gem install beggar

and run by

    beggar

### Configuration

Before first use, beggar will try to create configuration file in your home directory (~/.beggar)

Example config:

    company: pear
    token: abc123
    rate: 50.0

## Changelog
  v1.0.0 - first stable release


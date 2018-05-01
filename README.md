# Beggar [![Build Status](https://semaphoreci.com/api/v1/bkzl/beggar/branches/master/shields_badge.svg)](https://semaphoreci.com/bkzl/beggar)

## Description

Beggar is a tool for generating time reports from your Basecamp account

Example output:

    Current month
    Workdays:     78%
    Worked hours: 140.0h (-12.0h)
    Salary:       5320.0zł (-456.0zł)

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
    country: pl

## Changelog

<table>
    <tr>
        <td>v1.0.3</td><td>don't count holidays as working days</td>
    </tr>
    <tr>
        <td>v1.0.2</td><td>fix bug when time entries are empty</td>
    </tr>
    <tr>
        <td>v1.0.1</td><td>change output</td>
    </tr>
    <tr>
        <td>v1.0.0</td><td>first stable release</td>
    </tr>
</table>

## Contributors

[@grk](https://github.com/grk)

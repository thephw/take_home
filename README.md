# Project Title

Help folks figure out their take home pay and taxes. PRs welcome, add yo' own state to the FY2020 library.

Check for your own state and federal constants.

# Basic Usage
```
$ gem install take_home
```

```
require 'take_home'
you = TaxablePerson.single("georgia", 100_000)
you.take_home
=> 71790.5
```

# Initializing

## Options

By default the new TaxablePerson objects accept an dollar income and the following options:

```
:state_deductions # A number for state income deductions
:state_tax_rates # A hash where the key is the upper limit and the value is the percentage
:federal_deductions # A number for federal income deductions
:federal_tax_rates # A hash where the key is the upper limit and the value is the percentage
```

## Long Form

```
tchalla = TaxablePerson.single("wakanda", 48_000, opts = {
    state_deductions: 4600,
    state_tax_rates: {
      750 => 0.01,
      2250 => 0.02,
      3750 => 0.03,
      5250 => 0.04,
      7000 => 0.05,
      Float::INFINITY => 0.0575
    },
    federal_deductions: 12200,
    federal_tax_rates: {
      19400 => 0.10,
      78950 => 0.12,
      168400 => 0.22,
      321450 => 0.24,
      408200 => 0.32,
      612350 => 0.35,
      Float::INFINITY => 0.37
    }
  })
```

## Short Form Helpers

```
me = TaxablePerson.single("georgia", 48_000)
us = TaxablePerson.married("georgia", 96_000)
```

# Methods

```
#take_home returns income less federal income tax, state income tax, and payroll tax (social security + medicare)
#payroll_taxes returns the amount withheld for payroll taxes (SS + medicare)
#social_security_taxes returns the amount withheld for social security taxes
#medicare_taxes returns the amount withheld for medicare taxes
#federal_income_taxes returns the amount withheld for federal income taxes
#state_income_taxes returns the amount withheld for state income taxes
#taxes returns the cumulative amount withheld for federal income, state income, and payroll taxes
#effective_tax_rate shows a percentage effective tax rate
```

# Contributors

[Patrick Wiseman](https://github.com/thephw)

# License

[MIT License](https://github.com/thephw/take_home/blob/master/LICENSE)


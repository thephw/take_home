module TaxConstants
  module FY2020
    SOCIAL_SECURITY_WAGE_BASE = 137700
    SOCIAL_SECURITY_TAX_RATE = 0.062
    MEDICARE_TAX_RATE = 0.0145

    FEDERAL_SINGLE_STD_DEDUCTION = 12200
    FEDERAL_MARRIED_STD_DEDUCTION = 24400

    FEDERAL_SINGLE_INCOME_TAX_RATES = {
        9700 => 0.10,
       39475 => 0.12,
       84200 => 0.22,
      160725 => 0.24,
      204100 => 0.32,
      510300 => 0.35,
      Float::INFINITY => 0.37
    }

    FEDERAL_MARRIED_INCOME_TAX_RATES = {
       19400 => 0.10,
       78950 => 0.12,
      168400 => 0.22,
      321450 => 0.24,
      408200 => 0.32,
      612350 => 0.35,
      Float::INFINITY => 0.37
    }

    GEORGIA_SINGLE_STD_DEDUCTION = 4600
    GEORGIA_MARRIED_STD_DEDUCTION = 6000

    GEORGIA_SINGLE_INCOME_TAX_RATES = {
       750 => 0.01,
      2250 => 0.02,
      3750 => 0.03,
      5250 => 0.04,
      7000 => 0.05,
      Float::INFINITY => 0.0575
    }

    GEORGIA_MARRIED_INCOME_TAX_RATES = {
      1000 => 0.01,
      3000 => 0.02,
      5000 => 0.03,
      7000 => 0.04,
      10000 => 0.05,
      Float::INFINITY => 0.0575
    }

    LOOKUP = {
      single: {
        federal: {
          deduction: FEDERAL_SINGLE_STD_DEDUCTION,
          rates: FEDERAL_SINGLE_INCOME_TAX_RATES,
        },
        georgia: {
          deduction: GEORGIA_SINGLE_STD_DEDUCTION,
          rates: GEORGIA_SINGLE_INCOME_TAX_RATES,
        },
      },
      married: {
        federal: {
          deduction: FEDERAL_MARRIED_STD_DEDUCTION,
          rates: FEDERAL_MARRIED_INCOME_TAX_RATES,
        },
        georgia: {
          deduction: GEORGIA_MARRIED_STD_DEDUCTION,
          rates: GEORGIA_MARRIED_INCOME_TAX_RATES,
        },
      }
    }
  end
end

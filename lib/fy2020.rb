module TaxConstants
  module FY2020
    NO_DEDUCTION = 0
    FEDERAL_SINGLE_STD_DEDUCTION = 12_200
    FEDERAL_MARRIED_STD_DEDUCTION = 24_400

    SOCIAL_SECURITY_TAX_RATES = {
      137_700 => 0.062,
      Float::INFINITY => 0.0,
    }

    MEDICARE_SINGLE_TAX_RATES = {
      200_000 => 0.0145,
      Float::INFINITY => 0.0235,
    }

    MEDICARE_MARRIED_TAX_RATES = {
      250_000 => 0.0145,
      Float::INFINITY => 0.0235,
    }

    FEDERAL_SINGLE_INCOME_TAX_RATES = {
         9700 => 0.10,
       39_475 => 0.12,
       84_200 => 0.22,
      160_725 => 0.24,
      204_100 => 0.32,
      510_300 => 0.35,
      Float::INFINITY => 0.37
    }

    FEDERAL_MARRIED_INCOME_TAX_RATES = {
       19_400 => 0.10,
       78_950 => 0.12,
      168_400 => 0.22,
      321_450 => 0.24,
      408_200 => 0.32,
      612_350 => 0.35,
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
      10_000 => 0.05,
      Float::INFINITY => 0.0575
    }

    LOOKUP = {
      single: {
        federal: {
          deduction: FEDERAL_SINGLE_STD_DEDUCTION,
          rates: FEDERAL_SINGLE_INCOME_TAX_RATES,
        },
        social_security: {
          deduction: NO_DEDUCTION,
          rates: SOCIAL_SECURITY_TAX_RATES,
        },
        medicare: {
          deduction: NO_DEDUCTION,
          rates: MEDICARE_SINGLE_TAX_RATES,
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
        social_security: {
          deduction: NO_DEDUCTION,
          rates: SOCIAL_SECURITY_TAX_RATES,
        },
        medicare: {
          deduction: NO_DEDUCTION,
          rates: MEDICARE_MARRIED_TAX_RATES,
        },
        georgia: {
          deduction: GEORGIA_MARRIED_STD_DEDUCTION,
          rates: GEORGIA_MARRIED_INCOME_TAX_RATES,
        },
      }
    }
  end
end

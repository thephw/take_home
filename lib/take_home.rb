require_relative 'fy2020.rb'

class TaxablePerson
  attr_reader :income
  attr_reader :tax_type
  attr_reader :state

  def self.single(state, income, opts = {})
    new(:single, state, income, opts)
  end

  def self.married(state, income, opts = {})
    new(:married, state, income, opts)
  end

  def taxes
    federal_income_taxes + state_income_taxes + payroll_taxes
  end

  def federal_income_taxes
    marginal_taxes(income, federal_deductions, federal_tax_rates)
  end

  def state_income_taxes
    marginal_taxes(income, state_deductions, state_tax_rates)
  end

  def payroll_taxes
    social_security_taxes + medicare_taxes
  end

  def social_security_taxes
    if income < social_security_wage_base
      taxes = income * social_security_tax_rate
    else
      taxes = social_security_wage_base * social_security_tax_rate
    end
  end

  def medicare_taxes
    taxes = medicare_tax_rate * income
  end

  def effective_tax_rate
    taxes * 100.0 / income
  end

  def take_home
    income - taxes
  end

  private

  attr_accessor :tax_type
  attr_accessor :state
  attr_accessor :income
  attr_accessor :state_tax_rates
  attr_accessor :federal_tax_rates
  attr_accessor :medicare_tax_rate
  attr_accessor :social_security_tax_rate
  attr_accessor :social_security_wage_base
  attr_accessor :federal_deductions
  attr_accessor :state_deductions

  def configure(opts)
    self.state_deductions = opts[:state_deductions] || TaxConstants::FY2020::LOOKUP[tax_type][state][:deduction]
    self.state_tax_rates = opts[:state_tax_rates] || TaxConstants::FY2020::LOOKUP[tax_type][state][:rates]
    self.federal_deductions = opts[:federal_deductions] || TaxConstants::FY2020::LOOKUP[tax_type][:federal][:deduction]
    self.federal_tax_rates = opts[:federal_tax_rates] || TaxConstants::FY2020::LOOKUP[tax_type][:federal][:rates]
    self.social_security_tax_rate = opts[:social_security_tax_rate] || TaxConstants::FY2020::SOCIAL_SECURITY_TAX_RATE
    self.social_security_wage_base = opts[:social_security_wage_base] || TaxConstants::FY2020::SOCIAL_SECURITY_WAGE_BASE
    self.medicare_tax_rate = opts[:medicare_tax_rate] || calculate_medicare_tax_rate
    nil
  end

  def initialize(tax_type, state, income, opts)
    self.tax_type = tax_type.downcase.to_sym
    self.state = state.downcase.to_sym
    self.income = income.to_f
    configure(opts)
  end

  def marginal_taxes(income, deductions, rates)
    #Calculate AGI
    income = income - deductions
    #Calculate Income Taxes
    taxes = 0
    last_cap = 0
    rates.each do |cap, rate|
      amt = [income, cap].min
      taxes += [(amt - last_cap), 0].max * rate
      last_cap = cap
    end
    taxes
  end

  def calculate_medicare_tax_rate
    surplus_limit = case tax_type
    when :single
      TaxConstants::FY2020::MEDICARE_SURPLUS_WAGE_BASE_SINGLE
    when :married
      TaxConstants::FY2020::MEDICARE_SURPLUS_WAGE_BASE_MARRIED
    else
      throw "Unknown filling status (tax_type)"
    end
    tax_rate = TaxConstants::FY2020::MEDICARE_TAX_RATE
    if income >= surplus_limit
      tax_rate += TaxConstants::FY2020::MEDICARE_SURPLUS_TAX_RATE
    end
    tax_rate
  end
end

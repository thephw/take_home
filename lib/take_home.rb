require_relative 'fy2022.rb'

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
    marginal_taxes(income, federal_deduction, federal_tax_rates)
  end

  def state_income_taxes
    marginal_taxes(income, state_deduction, state_tax_rates)
  end

  def payroll_taxes
    social_security_taxes + medicare_taxes
  end

  def social_security_taxes
    marginal_taxes(income, social_security_deduction, social_security_tax_rates)
  end

  def medicare_taxes
    marginal_taxes(income, medicare_deduction, medicare_tax_rates)
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
  attr_accessor :medicare_tax_rates
  attr_accessor :social_security_tax_rates
  attr_accessor :federal_deduction
  attr_accessor :state_deduction
  attr_accessor :social_security_deduction
  attr_accessor :medicare_deduction

  def configure(opts)
    constants = TaxConstants::FY2022::LOOKUP[tax_type]
    self.state_tax_rates = opts[:state_tax_rates] || constants[state][:rates]
    self.federal_tax_rates = opts[:federal_tax_rates] || constants[:federal][:rates]
    self.social_security_tax_rates = opts[:social_security_tax_rate] || constants[:social_security][:rates]
    self.medicare_tax_rates = opts[:medicare_tax_rate] || constants[:medicare][:rates]

    self.federal_deduction = opts[:federal_deduction] || constants[:federal][:deduction]
    self.state_deduction = opts[:state_deduction] || constants[state][:deduction]
    self.social_security_deduction = opts[:social_security_deduction] || constants[:social_security][:deduction]
    self.medicare_deduction = opts[:medicare_deduction] || constants[:medicare][:deduction]
    nil
  end

  def initialize(tax_type, state, income, opts)
    self.tax_type = tax_type.downcase.to_sym
    self.state = state.downcase.to_sym
    self.income = income.to_f
    configure(opts)
  end

  def marginal_taxes(income, deduction, rates)
    #Calculate AGI
    income = income - deduction
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
end

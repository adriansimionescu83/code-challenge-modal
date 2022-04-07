require "pry-byebug"

class InvitationsController < ApplicationController
  def new
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new
    @invitation.cycle = @cycle
    respond_to do |format|
      format.js
    end
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @cycle = Cycle.find(params[:cycle_id])
    @invitation.cycle = @cycle
    handle_email_name(@invitation.email)
    if @invitation.save
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :message)
  end

  def handle_email_name(input)
    all_names_emails_array = segregate_names_and_emails(input)
    save_names_emails(all_names_emails_array)
    @has_valid_email = false
  end

  # The below method segregates the input from the user in two dimensional arrays, first dimension for each unique client, second dimension for client details - names and email
  def segregate_names_and_emails(input_user)
    pattern = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/
    input_array = input_user.split(' ')
    index = 0
    all_names_emails_array = []
    all_names_emails_array[0] = []
    input_array.each do |element|
      if element.match?(pattern)
        @has_valid_email = true
        all_names_emails_array[index] << element
        index += 1
        all_names_emails_array[index] = [] unless element == input_array.last
      else
        all_names_emails_array[index] << element.capitalize
      end
    end

    return all_names_emails_array
  end

  #The below method simply retrieves the email from the array composed of names and emails. Assumption is that in this array the email is always last.
  def retrieve_email(name_email_array)
    email = name_email_array.last

    return email
  end

  # The below method accepts an array composed of names (supports multiple names) and email and will return the full name contactenated as a single string
  def retrieve_full_name(name_email_array)
    full_name = name_email_array[0..-2].join(' ')

    return full_name
  end

  # The below method extracts the user name from the email address
  def extract_user_name_from_email(email)
    user_name = email.split('@').first.gsub(/[0-9]/, '') #Gets the string before the @ and removes the numerical characters
    name_array = user_name.split('.').map{ |name| name.capitalize } #This line creates an array of names and then capitalises each one
    full_name = name_array.join(' ')

    return full_name
  end

  def save_names_emails(all_names_emails_array)
    all_full_names = []
    all_emails = []

    all_names_emails_array.each do |element|
      full_name = retrieve_full_name(element)
      email = retrieve_email(element)
      full_name = extract_user_name_from_email(email) if full_name.empty?
      all_full_names << full_name
      all_emails << email
    end
    if @has_valid_email
      @invitation.email = all_emails.join(', ')
    else
      @invitation.email = nil
    end
    @invitation.display_name = all_full_names.join(', ')
  end
end

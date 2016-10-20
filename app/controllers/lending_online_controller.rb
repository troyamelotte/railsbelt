class LendingOnlineController < ApplicationController
  before_action :require_login_borrower, only: [:borrower]
  before_action :require_login_lender, only: [:lender, :lend]
  def borrower
    @borrower = Borrower.find(session[:borrower])
  end

  def lender
    @lender = Lender.find(session[:lender])
    @all_borrowers = Borrower.all.order(created_at: :desc)
  end

  def lend
    lend = Lender.find(session[:lender]).lendings.new(borrower_id:params[:id], ammount:params[:ammount])
    lender = Lender.find(session[:lender])
    unless lender.lending_to.include? Borrower.find(params[:id])
      lend.save
    else #for whatever reason i was getting errors with elsif
      if lender.money > params[:ammount].to_i
        lend = Lender.find(session[:lender]).lendings.find_by_borrower_id(params[:id])
        lend.ammount+=params[:ammount].to_i
        lend.save
      end
    end
    if lender.money < params[:ammount].to_i
      flash[:alert] = ["Not enough funds"]
    else
      lender.money -= params[:ammount].to_i
      lender.save
      borrower = Borrower.find(params[:id])
      puts borrower.ammount_raised
      borrower.ammount_raised += params[:ammount].to_i
      puts borrower.ammount_raised
      borrower.save
    end
    redirect_to '/lending_online/lender'
  end

  def logout
    session.clear
    redirect_to '/'
  end

  def newlender
    lender = Lender.new(lender_params)
    if lender.valid?
      lender.save
      session[:lender] = lender.id
      redirect_to '/lending_online/lender'
    else
      flash[:alert] = lender.errors.full_messages
      redirect_to '/lending_online/register'
    end
  end

  def newborrower
    borrower = Borrower.new(borrower_params)
    if borrower.valid?
      borrower.save
      session[:borrower] = borrower.id
      redirect_to '/lending_online/borrower'
    else
      flash[:alert] = borrower.errors.full_messages
      redirect_to '/lending_online/register'
    end
  end

  def login
  end

  def checkuser
    lender = Lender.find_by_email(params[:email])
    if lender && lender.authenticate(params[:password])
      session[:lender] = lender.id
      redirect_to '/lending_online/lender'
    else
      borrower = Borrower.find_by_email(params[:email])
      if borrower && borrower.authenticate(params[:password])
        session[:borrower] = borrower.id
        redirect_to '/lending_online/borrower'
      else
        flash[:alert] = ["invalid login"]
        redirect_to '/lending_online/login'
      end
    end
  end

  def register
  end

  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  end
  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :project, :desc, :ammount_needed)
  end
  def require_login_borrower
    redirect_to '/' unless session[:borrower]
  end
  def require_login_lender
    redirect_to '/' unless session[:lender]
  end
end

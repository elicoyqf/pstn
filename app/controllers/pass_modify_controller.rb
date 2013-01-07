#coding: utf-8
class PassModifyController < ApplicationController
  def modify
    render :layout => 'main_layout'
  end

  def m_submit
    o_pass = params[:o_pass]
    n_pass = params[:n_pass]
    a_pass = params[:a_pass]
    user   = User.find(session[:user_id])
    if Digest::MD5.hexdigest(o_pass) == user.password
      if n_pass == a_pass
        p_md5 = Digest::MD5.hexdigest(n_pass)
        user.update_attribute(:password, p_md5)
        flash[:notice] = '密码修改成功，请保存好你的新密码。'
        redirect_to action: 'modify'
      else
        flash[:notice] = '新密码两次确认不一致，请重新输入。'
        redirect_to action: 'modify'
      end
    else
      flash[:notice] = '原始密码输入不正确，请重新输入。'
      redirect_to action: 'modify'
    end

  end
end

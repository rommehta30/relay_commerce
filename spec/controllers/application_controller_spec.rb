# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user is signed in' do
      before do
        sign_in user
      end

      context "when user's quota has reached" do
        it 'should return over quota' do
          # TODO: Setup for quota exceeded
          get :index, params: {}
          expect_status(400)
        end
      end

      context "when user's quota is with in the limits" do
        it 'should return success' do
          get :index, params: {}
          expect_status(200)
        end
      end
    end

    context 'when user is not signed in' do
      it 'should return not authorized' do
        get :index, params: {}
        expect_status(401)
      end
    end
  end
end

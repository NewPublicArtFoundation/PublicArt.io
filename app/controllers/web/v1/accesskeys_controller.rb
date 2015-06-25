module Web
  module V1
    class AccesskeysController < ApplicationController
      before_action :set_accesskey, only: [:show, :edit, :update, :destroy]

      # GET /accesskeys
      # GET /accesskeys.json
      def index
        @accesskeys = Accesskey.all
      end

      # GET /accesskeys/1
      # GET /accesskeys/1.json
      def show
      end

      # GET /accesskeys/new
      def new
        @accesskey = Accesskey.new
      end

      # GET /accesskeys/1/edit
      def edit
      end

      # POST /accesskeys
      # POST /accesskeys.json
      def create
        @accesskey = Accesskey.new(accesskey_params)

        respond_to do |format|
          if @accesskey.save
            format.html { redirect_to @accesskey, notice: 'Accesskey was successfully created.' }
            format.json { render :show, status: :created, location: @accesskey }
          else
            format.html { render :new }
            format.json { render json: @accesskey.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /accesskeys/1
      # PATCH/PUT /accesskeys/1.json
      def update
        respond_to do |format|
          if @accesskey.update(accesskey_params)
            format.html { redirect_to @accesskey, notice: 'Accesskey was successfully updated.' }
            format.json { render :show, status: :ok, location: @accesskey }
          else
            format.html { render :edit }
            format.json { render json: @accesskey.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /accesskeys/1
      # DELETE /accesskeys/1.json
      def destroy
        @accesskey.destroy
        respond_to do |format|
          format.html { redirect_to accesskeys_url, notice: 'Accesskey was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_accesskey
          @accesskey = Accesskey.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def accesskey_params
          params.require(:accesskey).permit(:client_id, :client_secret, :callback_url, :source_url)
        end
    end
  end
end

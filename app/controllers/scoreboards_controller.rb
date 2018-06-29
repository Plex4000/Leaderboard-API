class ScoreboardsController < ApplicationController

    def getscores

        # scores = Scorecard.select('name, score').order('score DESC').each do |b|
        #     p b.to_json(only: [:name, :score,])
        # end
        # scores = Scorecard.pluck(:name, :score)
        scores = Scorecard.select([:id, :name, :score]).order('score DESC')
        # scores = Scorecard.find(:all, :select => 'id, name, score').order('score DESC')
        
        # render :json => scores

        if scores.count('score') > 10
            getFirstThree = scores.first(10)
            render json: {"message": "", "scores": getFirstThree}
        elsif scores.count('score') < 10
            render json: {"message": "", "scores": scores}
        else
            render json: {"message": "database is empty"}.to_json
        end
        
        # render json: {status 'SUCCESS', message: 'Returned Scores', data: scores}, status:OK

    end

    def postscore

        @score = Scorecard.new(score_params)

        if  @score.save

           render json: {"message": "saved"}.to_json

            # render json: @score, status: :created, location: @score
            # render json: @score
            
        else
            # render json: @score.errors, status: :unprocessable_entity
            render json: {"message": "not saved"}.to_json
        end

    end

            # if @score.save
        #     render "OK"
        # else
        #     render "Error"
        # end

    private
    def score_params
        params.require(:scorecard).permit(:name, :score)
    end

end

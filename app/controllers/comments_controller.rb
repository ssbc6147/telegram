class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            redirect_to posts_path, notice: "コメントを保存しました。"
        else
            @posts = Post.with_attached_image.order(created_at: :desc).page(params[:page]).per(5).includes(user: [avatar_attachment: :blob], comments: [user: [avatar_attachment: :blob]])
            render template: "posts/index"
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to posts_path, notice: "コメントを削除しました。"
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end
end

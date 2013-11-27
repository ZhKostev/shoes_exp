require File.expand_path('../app_setup', __FILE__)
require File.expand_path('../app/models/article', __FILE__)
require File.expand_path('../app/services/params', __FILE__)

class ShoesApp < Shoes

  url '/', :index
  url '/new', :new
  url '/edit', :edit
  url '/show', :show

  def index
    background gradient rgb(255, 255, 255), rgb(150, 150, 150)
    stack :margin => 20 do
      inscription 'MY ARTICLES: '
    end
    if @notice
      stack :margin => 20 do
        inscription "APP MESSAGE: #{@notice}"
        alert(@notice)
        @notice = nil
      end
    end
    stack :margin => 20 do
      flow :margin => 5 do
        stack :width => 50 do
          inscription 'ID'
        end
        stack :width => 150 do
          inscription 'TITLE'
        end
        stack :width => 350 do
          inscription 'BODY'
        end
        stack :width => 130 do
          inscription "ACTIONS"
        end
      end

      ::Article.limit(5).each do |article|
        flow :margin => 5 do
          stack :width => 50 do
            inscription article.id
          end
          stack :width => 150 do
            inscription article.title
          end
          stack :width => 350 do
            inscription article.body.length > 250 ? article.body[0..249] + '...' : article.body
          end
          stack :width => 130 do
            flow do
              stack :width => 55 do
                button "EDIT" do
                  ::Params.data = {:article_id => article.id}
                  visit '/edit'
                end
              end
              stack :width => 75 do
                button "DELETE" do
                  if confirm "DO YOU REALLY WANT TO DELETE #{article.title}?"
                    article.destroy
                    alert 'ARTICLE WAS SUCCESSFULLY DESTROYED!'
                    visit '/'
                  end
                end
              end
            end
          end
        end
      end

      stack do
        button "NEW" do
          visit '/new'
        end
      end
    end

  end

  def new
    background gradient rgb(255, 255, 255), rgb(150, 150, 150)
    stack :margin => 20 do
      inscription 'CREATE NEW ARTICLE'
    end
    stack :margin => 20 do
      inscription 'Title:'
      @title = edit_line :width => 600
      inscription 'Body:'
      @body = edit_box :width => 600, :height => 300
    end
    stack :margin => 20 do
      flow do
        button "CREATE" do
          @article = Article.new(:title => @title.text, :body => @body.text)
          if @article.save
            alert 'ARTICLE WAS SUCCESSFULLY CREATED!'
            visit '/'
          else
            alert @article.errors.messages.map { |k, v| "#{k} #{v.join(' and ')}" }.join('. And ')
          end
        end
        button "CANCEL" do
          visit '/'
        end
      end
    end
  end

  def edit
    background gradient rgb(255, 255, 255), rgb(150, 150, 150)
    @article = Article.find(::Params.data[:article_id])
    Params.data[:article_id] = nil
    stack :margin => 20 do
      inscription 'EDIT ARTICLE'
    end
    stack :margin => 20 do
      inscription 'Title:'
      @title = edit_line :width => 600
      @title.text = @article.title
      inscription 'Body:'
      @body = edit_box :width => 600, :height => 300
      @body.text = @article.body
    end
    stack :margin => 20 do
      flow do
        button "UPDATE" do
          if @article.update_attributes(:title => @title.text, :body => @body.text)
            alert 'ARTICLE WAS SUCCESSFULLY UPDATED!'
            visit '/'
          else
            alert @article.errors.messages.map { |k, v| "#{k} #{v.join(' and ')}" }.join('. And ')
          end
        end
        button "CANCEL" do
          visit '/'
        end
      end
    end
  end

end


Shoes.app(:title => 'Articles Manager', :width => 730)
require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe TopicsController, type: :controller do
	# let (:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:my_topic) { create(:topic)}
  let(:my_private_topic) { create(:topic, public: false) }

 context "guest" do 
	describe "GET index" do

		it "returns HTTP success" do 
			get :index
			expect(response).to have_http_status(:success)
		end

		it "assigns my_topic" do
			get :index
			expect(assigns(:topics)).to eq([my_topic])
		end

    it "does not include private topics in @topics" do 
      get :index
      expect(assigns(:topics)).not_to include(my_private_topic)
    end
	end

	describe "GET show" do
		it "return HTTP success" do
			get :show, {id: my_topic.id}
			expect(response).to have_http_status(:success)
		end

		it "renders the #show view" do
			get :show, {id: my_topic.id}
			expect(response).to render_template :show
		end

		it "assigns my_topoic to @topic" do
			get :show, {id: my_topic.id}
			expect(assigns(:topic)).to eq(my_topic)

		end

    it "directs from private topics" do 
      get :show, {id: my_private_topic.id}
      expect(response).to redirect_to(new_session_path)
    end
	end

	describe "GET new" do
		it "returns HTTP redirect" do 
			get :new
			expect(response).to redirect_to(new_session_path)
		end
	end

	describe "POST create" do
   		it "returns HTTP redirect" do
    		post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
    		expect(response).to redirect_to new_session_path
    	end
  end

  	describe "GET edit" do
  		it "returns http redirect" do
  			get :edit, {id: my_topic.id}
  			expect(response).to redirect_to(new_session_path)
  		end
  	end

  	describe "PUT update" do
  	 it "returns http redirect" do
  			new_name = RandomData.random_sentence
  			new_description = RandomData.random_paragraph
  			put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
  			expect(response).to redirect_to(new_session_path)
  		end			
  	end

  	describe "DELETE destory" do
  	 it "returns http redirect" do
  			delete :destroy, {id: my_topic.id} 
  			expect(response).to redirect_to new_session_path
  		end
  	end
  end
  
  context "member user" do 
   before do
      user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :member)
      create_session(user)
   end
  describe "GET index" do
    it "returns HTTP success" do 
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_topic/Topic.all to topic" do
      get :index
      expect(assigns(:topics)).to eq([my_topic, my_private_topic])
    end
  end

  describe "GET show" do
    it "return HTTP success" do
      get :show, {id: my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_topic.id}
      expect(response).to render_template :show
    end

    it "assigns my_topoic to @topic" do
      get :show, {id: my_topic.id}
      expect(assigns(:topic)).to eq(my_topic)

    end
  end

  describe "GET new" do
    it "returns http redirect" do 
      get :new
      expect(response).to redirect_to(topics_path)
    end
  end

  describe "POST create" do
      it "redirect http redirect" do 
        post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(response).to redirect_to topics_path
      end
  end

    describe "GET edit" do
     it "return http redirect" do 
        get :edit, {id: my_topic.id}
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "PUT update" do
     it "returns http redirect" do 
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph
        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        expect(response).to redirect_to(topics_path)
      end  
    end

    describe "DELETE destory" do
     it "redirects to topics index" do
        delete :destroy, {id: my_topic.id} 
        expect(response).to redirect_to topics_path
      end
    end
  end


 context "admin user" do 
  before do
    user = User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld", role: :admin)
    create_session(user)
  end
  describe "GET index" do
    it "returns HTTP success" do 
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_topic" do
      get :index
      expect(assigns(:topics)).to eq([my_topic, my_private_topic])
    end
  end

  describe "GET show" do
    it "return HTTP success" do
      get :show, {id: my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_topic.id}
      expect(response).to render_template :show
    end

    it "assigns my_topoic to @topic" do
      get :show, {id: my_topic.id}
      expect(assigns(:topic)).to eq(my_topic)

    end
  end

  describe "GET new" do
    it "returns HTTP success" do 
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "initialize @topic" do
      get :new
      expect(assigns(:topic)).not_to be nil
    end
  end

  describe "POST create" do
      it "incraeses the number of topics by 1" do
        expect { post :create,{topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}} }.to change(Topic, :count).by 1
      end

      it "assigns Topic.last to @topic" do
        post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(assigns(:topic)).to eq(Topic.last)
      end
    
      it "redirects to the new topic" do
        post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
        expect(response).to redirect_to Topic.last
      end
  end

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id:my_topic.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: my_topic.id}
        expect(response).to render_template :edit
      end

      it "assigns topic to be updated to @topic" do
        get :edit, {id: my_topic.id}
        topic_instance = assigns(:topic)
        expect(topic_instance.id).to eq(my_topic.id)
        expect(topic_instance.name).to eq(my_topic.name)
        expect(topic_instance.description).to eq(my_topic.description)
      end
    end

    describe "PUT update" do
      it "updates topic with expected attributes" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph
        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        updated_topic = assigns(:topic)
        expect(updated_topic.id).to eq(my_topic.id)
        expect(updated_topic.name).to eq new_name
        expect(updated_topic.description).to eq new_description
      end
      
      it "redirects to the updated topic" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph
        put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
        expect(response).to redirect_to my_topic
      end     
    end

    describe "DELETE destory" do
        it "delete the topic" do
        delete :destroy, {id: my_topic.id}
        count = Post.where({id: my_topic.id}).size
        expect(count).to eq 0
      end

      it "redirects to topics index" do
        delete :destroy, {id: my_topic.id} 
        expect(response).to redirect_to topics_path
      end
    end
  end
end

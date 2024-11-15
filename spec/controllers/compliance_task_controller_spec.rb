# spec/controllers/compliance_tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe ComplianceTasksController, type: :controller do
  let!(:compliance_task) { create(:compliance_task) }
  let(:valid_attributes) do
    { title: 'Test Task', status: 'pending', description: 'Test Description', due_date: Date.tomorrow }
  end
  let(:invalid_attributes) { { title: '', status: '', description: '', due_date: nil } }

  describe 'GET #index' do
    it 'returns a list of compliance tasks' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['tasks']).to be_present
    end

    it 'filters tasks by status' do
      get :index, params: { status: compliance_task.status }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['tasks'].first['status']).to eq(compliance_task.status)
    end

    it 'filters tasks by due_date' do
      get :index, params: { due_date: Date.tomorrow }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    context 'when task exists' do
      it 'returns the task' do
        get :show, params: { id: compliance_task.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['task']['id']).to eq(compliance_task.id)
      end
    end

    context 'when task does not exist' do
      it 'returns not found' do
        get :show, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Compliance task not found')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new task' do
        expect do
          post :create, params: { compliance_task: valid_attributes }
        end.to change(ComplianceTask, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new task' do
        expect do
          post :create, params: { compliance_task: invalid_attributes }
        end.not_to change(ComplianceTask, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'when task exists' do
      it 'updates the task with valid attributes' do
        put :update, params: { id: compliance_task.id, compliance_task: { title: 'Updated Task' } }
        expect(response).to have_http_status(:ok)
        expect(compliance_task.reload.title).to eq('Updated Task')
      end

      it 'does not update the task with invalid attributes' do
        put :update, params: { id: compliance_task.id, compliance_task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when task does not exist' do
      it 'returns not found' do
        put :update, params: { id: -1, compliance_task: valid_attributes }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when task exists' do
      it 'deletes the task' do
        expect do
          delete :destroy, params: { id: compliance_task.id }
        end.to change(ComplianceTask, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when task does not exist' do
      it 'returns not found' do
        delete :destroy, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

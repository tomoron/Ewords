require 'rails_helper'

RSpec.describe 'Study', type: :system, js: true do
  let(:word) {create(:word)}

  describe 'index' do
    it 'ボタンが表示される' do
      visit study_index_path
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'primer',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'basic',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'abvance',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'abbreviation',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'initial',num: 0)
    end
  end

  describe 'show' do
    before do
      create_list(:word, 10,level: 'primer')
      visit word_study_index_path(level: 'primer',num: 0)
    end
    it '選択肢ボタンが4個表示される' do
      expect(all("button[data-action='click->word#next']").length).to eq 4
    end

    it '選択肢ボタンを押すと変化する(正解)' do
      find("#correct").click
      expect(page).to have_selector '#correct' ,class:'bg-green-200'
      expect(page).to have_selector '#correct' ,class:'dark:bg-green-300'
    end

    it '選択肢ボタンを押すと変化する(不正解)' do
      first(".incorrect").click
      expect(page).to have_selector '.incorrect' ,class:'bg-red-200'
      expect(page).to have_selector '.incorrect' ,class:'dark:bg-red-300'
    end
  end

  describe 'result' do

  end
end

require "rails_helper"

describe "/forex" do

  it "has a level one heading with the text 'Currency pairs'", points: 1 do
    visit "/forex"

    expect(page).to have_tag("h1", text: /Currency pairs/i)
  end
end

describe "/forex" do
  it "lists each of the Currency Symbols from the API", points: 2 do
    visit "/forex"
      expect(page).to have_content("AED")
      expect(page).to have_content("AFN")
      expect(page).to have_content("ALL")
      expect(page).to have_content("AMD")
      expect(page).to have_content("ANG")
      expect(page).to have_content("AOA")
      expect(page).to have_content("TMT")
      expect(page).to_not have_content("BOB"),
        "Expected not to find the symbol 'BOB', hardcoded into the HTML but found it anywa, points: 1y."
    
  end
end

describe "/forex" do
  it "has a link to '/forex/X', where 'X' is a currency symbol, for each currency symbol", points: 1 do
    visit "/forex"
    
    expect(page).to have_tag("a", :with => { :href => "/forex/AED"})
    expect(page).to have_tag("a", :with => { :href => "/forex/AFN"})
    expect(page).to have_tag("a", :with => { :href => "/forex/ALL"})
    expect(page).to have_tag("a", :with => { :href => "/forex/AMD"})
    expect(page).to have_tag("a", :with => { :href => "/forex/ANG"})
    expect(page).to have_tag("a", :with => { :href => "/forex/AOA"})
    expect(page).to have_tag("a", :with => { :href => "/forex/TMT"})
  end
end

describe "/forex/[CURRENCY SYMBOL]" do

  it "has a level one heading with the text 'Convert [CURRENCY SYMBOL]'", points: 1 do
    visit "/forex/CUP"
    
    expect(page).to have_tag("h1", text: /Convert CUP/i)
  end
end

describe "/forex/[CURRENCY SYMBOL]" do

  it "has a level one heading with the text 'Convert [CURRENCY SYMBOL]'", points: 1 do
    visit "/forex/SVC"

    expect(page).to have_tag("h1", text: /Convert SVC/i)

    visit "/forex/WST"

    expect(page).to have_tag("h1", text: /Convert WST/i)
  end
end

describe "/forex/[CURRENCY SYMBOL]" do

  it "has a link with the text 'back' to '/forex'", points: 1 do
    visit "/forex/TMT"

    expect(page).to have_tag("a", :with => { :href => "/forex"}, :text => /back/i),
      "Expected to find <a> tag with the text 'back' and an href='/forex', but didnt' find one."
    end
  end
  
  describe "/forex/[CURRENCY SYMBOL]" do

    it "has a link with the text, 'Convert 1 X to Y...', to '/forex/X/Y', for each currency symbol", points: 1 do
      
      visit "/forex/TMT"
    
      expect(page).to have_tag("a", :with => { :href => "/forex/TMT/AMD"}, :text => /Convert 1 TMT to AMD/i),
        "Expected page to have a link with the text, 'Convert 1 TMT to AMD...', with an href='/forex/TMT/AMD', but didnt' find one."
      
      expect(page).to have_tag("a", :with => { :href => "/forex/TMT/AOA"}, :text => /Convert 1 TMT to AOA/i),
        "Expected page to have a link with the text, 'Convert 1 TMT to AOA...', with an href='/forex/TMT/AOA', but didnt' find one."
      
  end
end

describe "/forex/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has a level one heading with the text 'Convert [CURRENCY SYMBOL] to [CURRENCY SYMBOL]'", points: 1 do
    visit "/forex/ANG/AOA"
    
    expect(page).to have_tag("h1", text: /Convert ANG to AOA/i)
  end
end

describe "/forex/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has the text '1 [CURRENCY SYMBOL] equals [CURRENCY SYMBOL]'", points: 1 do

    visit "/forex/CUP/SVC"
    p page.text
    expect(page).to have_text(/1 CUP equals 0.339787 SVC/i),
      "Expected page to have text that follows the pattern, '1 CUP equals 0.339787 SVC', but it didn't."
    
  end
end

describe "/forex/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has a link with the text 'back' to '/forex/[CURRENCY SYMBOL]'", points: 1 do

    visit "/forex/CUP/SVC"
    
    expect(page).to have_tag("a", :with => { :href => "/forex/CUP"}, :text => /back/i)
    
  end
end

describe "/forex/[CURRENCY SYMBOL]/[CURRENCY SYMBOL]" do
  it "has a link with the text 'back' to '/forex/[CURRENCY SYMBOL]'", points: 1 do

    visit "/forex/ANG/AOA"
    
    expect(page).to have_tag("a", :with => { :href => "/forex/ANG"}, :text => /back/i)
  end
end

require 'nokogiri'
require 'open-uri'

def readtables(page_name)
    spell_links = []
    open(page_name) do |page|
        doc = Nokogiri::HTML(open(page_name))
        doc.css('table[bordercolor="#888888"]').each do |table|
            spell_links.concat links_from table
        end
    end

    return spell_links
end

def links_from(a_table)
    links = []
    rows = a_table.child.children # Child is <tbody>
    rows[1..-1].each do |row| # First row is headers
        first_cell = row.children.first
        first_cell.children.each do |link_node|
            link = link_node['href']
            links << link unless link.nil?
        end
    end
    
    return links
end

# Заполнить хеш гласными буквами,
# где значением будет являтся порядковый номер буквы в алфавите (a - 1)

# все гласные буквы английского алфавита
vowel_letters = ['a', 'e', 'i', 'o', 'u']
vowels = {}
('a'..'z').each.with_index(1) do |letter, i|
  if vowel_letters.include? letter
    # заносим гласную букву в хеш в качестве ключа, индекс - номер буквы
    vowels[letter] = i
  end
end

puts vowels

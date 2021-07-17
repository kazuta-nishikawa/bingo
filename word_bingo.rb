# 標準入力からマス数の値取得
@s = gets.to_i

# ビンゴカードを二重配列で作成
bingo_card = Array.new
for i in 1..@s
    bingo_card << gets.chomp!.split
end

# 穴をあけられる単語の配列を作成
n = gets.to_i
bingo_words = Array.new
for i in 1..n
    bingo_words << gets.chomp!
end

# ビンゴカードに正解の単語があるか調べて、当たっている単語に印をつける
hit_list = Array.new
bingo_card.each do |r|
    r.each do |w|
        if bingo_words.include?(w)
            hit_list << true
        else
            hit_list << false
        end
    end
end

# hit_listをビンゴカードの形式にする
@hit_card = hit_list.each_slice(@s).to_a

# 横判定
# all?は要素がすべて真ならtrue S個の要素すべてtrueなら真を返す。ー＞ビンゴ
rows = Array.new
for i in 0...@s
    rows << @hit_card[i].all?
end
rows = rows.any?

# 縦判定
# transposeは自身を行列に見立てて、転換する（縦のマスを配列とみなす。）
columns = Array.new
t_hit_card = @hit_card.transpose
for i in 0...@s
    columns << t_hit_card[i].all?
end
columns = columns.any?

# 斜め判定
# 右肩あがり
# ブロックのなかでインデックス指定の値取得ができないため関数を作成
def up(i)
    return @hit_card[i][@s-1-i] 
end

growing = Array.new()
for i in 0...@s
    growing << up(i)
end
growing =  growing.all?

# 右肩下がり
def down(i)
    return @hit_card[i][i] 
end

declinig = Array.new()
for i in 0...@s
    declinig << down(i)
end
declinig =  declinig.all?

# 結果出力
if columns || rows || growing || declinig
    puts "yes"
else
    puts "no"
end
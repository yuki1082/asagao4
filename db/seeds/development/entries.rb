body =
  " 今晩は久しぶりに神宮で野球観戦。内野 B 席の上段に着席。÷ n" +
  " 先発はヤクルト館山、広島福井。 " +
  "5 回までは 0 対 0 の投手戦で、ヤクルトはノーヒット。 " +
  "6 回に試合が動き出し、 2 点先行されます。 " +
  " しかしその裏、畠山の満塁弾に宮本のソロで大逆転!÷ n" +
  " しかし 7 回に押本が大乱調、栗原に満塁弾をお返しされてしまいました。 "
%w(Taro Jiro Hana).each do |name|
  member = Member.find_by(name: name)
  0.upto(9) do |idx|
    Entry.create(
      author: member,
      title: " 野球観戦 #{idx}",
      body: body,
      posted_at: 10.days.ago.advance(days: idx),
    status: %w(draft member_only public)[idx % 3])
  end
end

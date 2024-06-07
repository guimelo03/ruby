namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop)}
      show_spinner("Criando BD...") { %x(rails db:create)}
      show_spinner("Migrando BD...") { %x(rails db:migrate)}
      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas") do
      coins = [ 
        {
        description: "Bitcoin",
        acronym: "BTC",
        url_image: "https://img.freepik.com/vetores-gratis/fundo-de-moeda-dourada-com-bitcoin-criptomoeda_1017-31505.jpg"
        },

        {
        description: "Dash",
        acronym: "DASH",
        url_image: "data:image/png;base64,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"
        },
      ]
  coins.each do |coin|

  Coin.find_or_create_by(coin) #Cria se não houver
  end
  puts 'Moedas cadastradas com sucesso!'
end
end

  desc "Cadastro dos tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração!") do
    mining_types = [
      {description: "Proof of Work", acronym:"PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]

    mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
    end
  end
end


  private 
  
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end


end

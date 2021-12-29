require 'text2voice'
require 'dotenv'
require 'tempfile'
require 'yaml'

Dotenv.load

Param = Struct.new(:text, :speaker, :emotion, :emotion_level, :pitch, :speed, :volume) do
  def to_s
    "#{speaker} #{emotion}-#{emotion_level} pitch:#{pitch}% speed:#{speed}%"
  end
  def to_a
    [text, speaker, emotion, emotion_level, pitch, speed]
  end
end

@voice = TextToVoice.new(ENV["TEXT2VOICE_APIKEY"])
@histories_path = File.join(File.dirname(__FILE__), "history.yml")

def load_histories
  if File.exist?(@histories_path)
    YAML.load(File.read(@histories_path)).map{|a| Param.new *a }
  else
    []
  end
end

@histories = load_histories
@param = @histories.first || Param.new("こーんにーちは。こんにちはじゃねぇよこんばんはだろう。", "haruka", "happiness", 4, 100, 100)

def save_histories
  File.write(@histories_path, @histories.map{|h| h.to_a}.to_yaml)
end

def supported_speaker? speaker
  %(haruka hikari takeru santa bear).include? speaker
end

def speak param=@param
  @voice.speak(param.text)
    .speaker(param.speaker)
    .pitch(param.pitch)
    .speed(param.speed)
    .emotion(
      emotion: supported_speaker?(param.speaker) ? param.emotion : nil,
      level: param.emotion_level)

  tf = Tempfile.create("test.wav")
  @voice.save_as(tf.path)
  `afplay #{tf.path}`
  File.delete tf.path
  @histories.delete param
  @histories.unshift param
  @histories.take(10)
  save_histories
end

def text_menu
  puts
  print "Input text to say: "
  t = gets.chomp
  @param.text = t unless t.length == 0
  puts
end

def speaker_menu
  speakers = %w(show haruka hikari takeru santa bear)
  done = false
  until done
    puts
    speakers.each_with_index do |s, i|
      puts "#{i + 1}. #{s}"
    end
    puts
    print "Choose the speaker: "
    
    i = gets.to_i
    case i
    when 1..speakers.size
      @param.speaker = speakers[i - 1]
      done = true
    end
  end
end

def emotion_menu
  emotions = %w(happiness anger sadness)
  done = false
  until done
    puts
    emotions.each_with_index do |s, i|
      puts "#{i + 1}. #{s}"
    end
    puts
    print "Choose the emotion: "
    
    i = gets.to_i
    case i
    when 1..emotions.size
      @param.emotion = emotions[i - 1]
      done = true
    end
  end
end

def emotion_level_menu
  levels = 1..4
  done = false
  until done
    puts
    print "Input the emotion level [1-4] : "

    i = gets.to_i
    case i
    when 1..4
      @param.emotion_level = i
      done = true
    end
  end

end

def pitch_menu
  levels = 1..4
  range = 50..200
  done = false
  until done
    puts
    print "Input the pitch [#{range.first}-#{range.end}]% : "

    i = gets.to_i
    case i
    when range
      @param.pitch = i
      done = true
    end
  end

end

def speed_menu
  levels = 1..4
  range = 50..400
  done = false
  until done
    puts
    print "Input the speed [#{range.first}-#{range.end}]% : "

    i = gets.to_i
    case i
    when range
      @param.speed = i
      done = true
    end
  end

end

def history_menu
  range = 1..@histories.count
  done = false
  until done
    puts
    @histories.each_with_index do |h, i|
      puts "#{i + 1}. #{h}"
    end
    puts "B. back"
    puts
    print "Choose a history : "
    
    s = gets.chomp
    case s
    when /b/i, /q/i
      done = true
    when lambda {|s| range.include? s.to_i }
      h = @histories[s.to_i - 1]
      h.text = @param.text
      speak h
    end
  end
end

def top_menu
  print <<EOS

0. Play selectd condition.
1. Set text to say.         current: #{@param.text}
2. Select speaker.          current: #{@param.speaker}
3. Select emotion.          current: #{@param.emotion}
4. Set emotion level.       current: #{@param.emotion_level}
5. Set pitch.               current #{@param.pitch}%
6. Set speed.               current #{@param.speed}%
7. History.
Q. Quit.

Choose a command No.: 
EOS
.chomp

  case gets.chomp!
  when "0", ""
    speak
  when "1"
    text_menu
  when "2"
    speaker_menu
  when "3"
    emotion_menu
  when "4"
    emotion_level_menu
  when "5"
    pitch_menu
  when "6"
    speed_menu
  when "7", /h/i
    history_menu
  when "8"
  when "9", /q/i
    return false
  end
  return true
end

while top_menu; end

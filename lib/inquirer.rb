require 'inquirer/version'
require 'inquirer/utils/iohelper'
require 'inquirer/prompts/checkbox'
require 'inquirer/prompts/confirm'
require 'inquirer/prompts/input'
require 'inquirer/prompts/list'
require 'inquirer/prompts/password'

module Inquirer

  extend self

  def prompt(prompts)

    answers = {}
    prompts.each { |prompt|

      # TODO: maybe use prompt.fetch(:type, :input) ???
      prompt[:type] ||= :input

      prompt_answers = []

      if prompt[:when].is_a?(Proc)

        ask_prompt = prompt[:when].call( answers )

        next if !ask_prompt
      elsif [true, false].include? prompt[:when]
        next if !prompt[:when]
      end

      if !prompt[:repeat].is_a?(Integer) and ![true, false].include? prompt[:repeat] # Boolean check :(
        prompt[:repeat] = 1
      end

      repeat_prompt = lambda { |repeat_counter|

        if prompt[:manipulate] && prompt[:manipulate].is_a?(Proc)

          manipulate_parameter = prompt.merge(
            answers:        answers,
            repeat_counter: repeat_counter,
          )

          prompt = prompt[:manipulate].call( manipulate_parameter )

          next if !prompt
        end

        type_parameter = prompt.merge(
          answers:        answers,
          repeat_counter: repeat_counter,
        )

        object = Kernel.const_get(prompt[:type].to_s.capitalize)
        answer = object.prompt(type_parameter)

        if prompt[:filter] && prompt[:filter].is_a?(Proc)
          answer = prompt[:filter].call( answer )
        end

        prompt_answers.push answer
      }

      if prompt[:repeat].is_a?(Integer)
        (1..prompt[:repeat]).each(&repeat_prompt)
      else

        begin
          repeat_counter = 1
          loop {
            repeat_prompt.call(repeat_counter)
            repeat_counter += 1
          }
        rescue Interrupt
        end
      end

      if prompt[:repeat] == 1
        answers[ prompt[:name] ] = prompt_answers.first
      else
        answers[ prompt[:name] ] = prompt_answers
      end
    }

    answers
  end
end
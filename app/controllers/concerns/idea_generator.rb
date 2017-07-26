class IdeaGenerator
    PHRASES_SET_1 = [
        'gesture-controlled',
        'voice-controlled',
        'adaptive',
        'responsive',
        'artificial intelligence',
        'smart',
        'context-aware',
        'immersive',
        'content-first',
        'distributed',
        'interactive',
        'collaborative',
        'cloud-based',
        'machine-learning',
        '3D',
        'embedded',
        'machine-learning',
        'WebGL',
        'wearable',
        'location-based',
        'educational',
        'touch-based'
    ]

    PHRASES_SET_2 = [
        'mobile',
        'social',
        'tablet',
        'mobile-first',
        'analysis',
        'recommendation',
        'smartphone',
        'smart-watch',
        'cloud',
        'learning',
        'web',
        'mobile web',
        'geolocation',
        'gaming',
        'e-Reader',
        'iBook',
        'personalisation'
    ]

    PHRASES_SET_3 = [
        'app',
        'platform',
        'site',
        'framework',
        'algorithm',
        'service',
        'network',
        'API'
    ]

    PHRASES_SET_4 = [
        '#hackharassment',
        'generate project ideas',
        'solve puzzles',
        'calculate pizza costs',
        'drink Soylent automatically',
        'solve Bloomberg puzzles',
        'link all social media accounts',
        'save your Snapchats',
        'find love',
        'blast asteroids',
        'save the princess',
        'not throw away your shot',
        'find the best prices',
        'find waldo',
        'eat insomnia cookies',
        'hack every weekend',
        'not procastinate',
        'get a 36 on your ACT',
        'eat, code, sleep, repeat',
        'keep calm and code on',
        'stay out of trouble',
        'stay in school',
        'not use fake IDs',
        'disregard females, acquire currency',
        'get paper',
        'eat cookies, chocolate, and code',
        'make money',
        'go to hackathons',
        'become the next Mark Zuberberg',
        'transform into Steve Jobs',
        'disrupt the farming industry',
        'disrupt the cattle industry',
        'help high school debaters',
        'disrupt the cheese industry',
        'disrupt the notebook industry',
        'disrupt the lawnmower industry',
        'encourage recycling',
        'make finding hotels easy',
        'make finding food easy',
        'make finding boats easy',
        'make finding taxis easy',
        'make finding music stores easier',
        'shop in virtual reality',
        'visualize music'
    ]

    def self.generate_idea(language)
        random_type = PHRASES_SET_1[rand(PHRASES_SET_1.length)]
        random_adjective = PHRASES_SET_2[rand(PHRASES_SET_2.length)]
        random_noun = PHRASES_SET_3[rand(PHRASES_SET_3.length)]
        random_audience = PHRASES_SET_4[rand(PHRASES_SET_4.length)]

        "A #{random_type} #{random_adjective} #{random_noun} written in #{language} to #{random_audience}"
    end
end

class @People extends Module
  @include Modules.value
  @include Modules.modifier
  @include Modules.assignment

  constructor: (config, @state) ->
    super
    @name = 'people'
    @assignmentSlots.set [
      'woodcutter'
      'farmer'
    ]

    Tracker.autorun =>
      @setValue(@modifiers.get('houses') or 0)    
    
    Tracker.autorun =>
      @assignmentCapacity.set @getValue()
      
    Tracker.autorun =>
      @state.buckets.resources.food.setModifier 'people', -0.5 * @getValue()

    Tracker.autorun =>
      @state.buckets.resources.wood.setModifier 'woodcutters', 0.015 * @assignment.get('woodcutter')

    Tracker.autorun =>
      @state.buckets.resources.food.setModifier 'farmers', 1 * @assignment.get('farmer')
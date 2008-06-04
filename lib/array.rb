module ApplicationSupport
  module ArrayExtensions
    def divided_by(n)
      return self if n <= 1
      divmod = self.length.divmod n
      count  = divmod.shift
      unless divmod.shift.zero?
        count += 1
      end
      out = []
      start = 0
      n.times do |i|
        out << (self[start, count] || [])
        start = count * (i + 1)
      end
      out
    end
  end
end

Array.send :include, ApplicationSupport::ArrayExtensions
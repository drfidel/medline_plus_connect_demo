var DiagnosisCodeDemo = DiagnosisCodeDemo || {};

DiagnosisCodeDemo.Code = {
  /**
   * Open all of NLM's links in a new tab.
   */
  openNLMLinksInNewTabs: function() {
    $('.cont__nlm-description a').attr('target', '_blank').attr('rel', 'external');
  },

  /**
   * Animate each description entry by sliding it open.
   */
  toggleDescriptions: function() {
    $('.card-group').each(function() {
      $(this).slideToggle('slow');
    });
  }
}
